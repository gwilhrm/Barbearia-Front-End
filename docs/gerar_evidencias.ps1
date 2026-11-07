param([string]$Destino = '')

# Executar na raiz: powershell -ExecutionPolicy Bypass -File docs/gerar_evidencias.ps1
# Ferramenta de documentação: não modifica os HTMLs, CSS ou evidências anteriores.
$ErrorActionPreference = 'Stop'
$raiz = Split-Path $PSScriptRoot -Parent
if (!$Destino) { $Destino = Join-Path $PSScriptRoot ('evidencias/revisao_' + (Get-Date -Format 'yyyy-MM-dd_HHmmss')) }
if (Test-Path -LiteralPath $Destino) { throw 'Escolha uma pasta nova para preservar as evidências.' }
$saida = New-Item -ItemType Directory -Path $Destino
$utf8 = New-Object System.Text.UTF8Encoding($false)
function Salvar-Json($nome, $dados) {
    [IO.File]::WriteAllText((Join-Path $saida.FullName $nome), (ConvertTo-Json -InputObject $dados -Depth 40), $utf8)
}
$anteriores = @(Get-ChildItem (Join-Path $PSScriptRoot 'evidencias') -File | ForEach-Object {
    @{ arquivo = $_.Name; sha256 = (Get-FileHash $_.FullName -Algorithm SHA256).Hash }
})
Salvar-Json 'historico_preservado.json' $anteriores
$fontes = @(Get-ChildItem $raiz -Filter '*.html') + @(Get-Item (Join-Path $raiz 'css/style.css')) + @(Get-ChildItem (Join-Path $raiz 'img') -File)
Salvar-Json 'fontes_sha256.json' @($fontes | ForEach-Object { @{ arquivo = $_.FullName.Substring($raiz.Length + 1).Replace('\','/'); sha256 = (Get-FileHash $_.FullName -Algorithm SHA256).Hash } })

$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$perfil = Join-Path ([IO.Path]::GetTempPath()) ('studioxxi-evidencias-' + [guid]::NewGuid())
# Uma porta livre por execução evita compartilhar a aba com outra coleta.
$reserva = New-Object Net.Sockets.TcpListener([Net.IPAddress]::Loopback, 0)
$reserva.Start()
$porta = $reserva.LocalEndpoint.Port
$reserva.Stop()
$processo = Start-Process -FilePath $edge -WindowStyle Hidden -PassThru -ArgumentList @('--headless=new','--disable-gpu','--no-first-run','--no-default-browser-check',"--remote-debugging-port=$porta",('--user-data-dir="' + $perfil + '"'),'about:blank')
$socket = New-Object Net.WebSockets.ClientWebSocket
$script:id = 0
function Cdp($metodo, $parametros = @{}) {
    $script:id++
    $msg = @{ id = $script:id; method = $metodo; params = $parametros } | ConvertTo-Json -Depth 30 -Compress
    $bytes = [Text.Encoding]::UTF8.GetBytes($msg)
    $segmento = New-Object 'System.ArraySegment[byte]' -ArgumentList (,$bytes)
    $socket.SendAsync($segmento, [Net.WebSockets.WebSocketMessageType]::Text, $true, [Threading.CancellationToken]::None).GetAwaiter().GetResult() | Out-Null
    do {
        $memoria = New-Object IO.MemoryStream
        do {
            $buffer = New-Object byte[] 65536
            $segmento = New-Object 'System.ArraySegment[byte]' -ArgumentList (,$buffer)
            $recebido = $socket.ReceiveAsync($segmento, [Threading.CancellationToken]::None).GetAwaiter().GetResult()
            $memoria.Write($buffer, 0, $recebido.Count)
        } until ($recebido.EndOfMessage)
        $resposta = [Text.Encoding]::UTF8.GetString($memoria.ToArray()) | ConvertFrom-Json
        $memoria.Dispose()
    } until ($resposta.id -eq $script:id)
    if ($resposta.error) { throw ($resposta.error | ConvertTo-Json -Compress) }
    return $resposta.result
}
function Js($codigo) {
    $r = Cdp 'Runtime.evaluate' @{ expression = $codigo; returnByValue = $true; awaitPromise = $true }
    if ($r.exceptionDetails) { throw ($r.exceptionDetails | ConvertTo-Json -Depth 10) }
    return $r.result.value
}
function Abrir($pagina) {
    $url = ([uri](Join-Path $raiz $pagina)).AbsoluteUri
    Cdp 'Page.navigate' @{url=$url} | Out-Null
    for ($i=0; $i -lt 50; $i++) {
        Start-Sleep -Milliseconds 100
        if ((Js 'location.href') -eq $url -and (Js 'document.readyState') -ne 'loading') { break }
    }
    if ((Js 'location.href') -ne $url) { throw "Não abriu $pagina" }
}
function Capturar($nome) {
    $layout = Cdp 'Page.getLayoutMetrics'
    $r = Cdp 'Page.captureScreenshot' @{ format='png'; captureBeyondViewport=$true; clip=@{ x=0; y=0; width=$layout.cssContentSize.width; height=$layout.cssContentSize.height; scale=1 } }
    [IO.File]::WriteAllBytes((Join-Path $saida.FullName $nome), [Convert]::FromBase64String($r.data))
}

try {
    for ($i=0; $i -lt 40; $i++) {
        try { $abas = Invoke-RestMethod "http://127.0.0.1:$porta/json/list" -TimeoutSec 1; break } catch { Start-Sleep -Milliseconds 200 }
    }
    if (!$abas) { throw 'Edge não iniciou a porta de depuração; confira as permissões de execução.' }
    $aba = $abas | Where-Object type -eq 'page' | Select-Object -First 1
    $socket.ConnectAsync([uri]$aba.webSocketDebuggerUrl, [Threading.CancellationToken]::None).GetAwaiter().GetResult() | Out-Null
    Cdp 'Page.enable' | Out-Null
    $navegador = Cdp 'Browser.getVersion'
    $paginas = @()
    foreach ($largura in @(1280)) {
        Cdp 'Emulation.setDeviceMetricsOverride' @{width=$largura;height=1000;deviceScaleFactor=1;mobile=$false} | Out-Null
        foreach ($arquivo in (Get-ChildItem $raiz -Filter '*.html' | Sort-Object Name)) {
            Abrir $arquivo.Name
            $dados = Js @'
(() => {
 const attrs = e => Object.fromEntries(Array.from(e.attributes, a => [a.name,a.value]));
 const all = s => Array.from(document.querySelectorAll(s));
 const ids = all('[id]').map(e=>e.id);
 return {
  arquivo: location.pathname.split('/').pop(), largura: innerWidth, larguraDocumento: document.documentElement.scrollWidth,
  transbordamento: document.documentElement.scrollWidth > innerWidth,
  titulo: document.title, h1: all('h1').length, header: all('header').length, main: all('main').length, footer: all('footer').length,
  idsDuplicados: ids.filter((x,i)=>ids.indexOf(x)!==i), labelsSemCampo: all('label[for]').filter(e=>!document.getElementById(e.htmlFor)).map(attrs),
  menu: all('nav a').map(e=>({href:e.getAttribute('href'), atual:e.getAttribute('aria-current'), cor:getComputedStyle(e).backgroundColor})),
  referencias: all('[href],[src]').flatMap(e=>['href','src'].filter(a=>e.hasAttribute(a)).map(a=>({tag:e.tagName.toLowerCase(), atributo:a, valor:e.getAttribute(a)}))),
  imagens: all('img').map(e=>({src:e.getAttribute('src'), alt:e.getAttribute('alt'), carregada:e.complete && e.naturalWidth>0})),
  formularios: all('form').map(f=>({action:f.getAttribute('action'), method:f.getAttribute('method'), campos:Array.from(f.elements).filter(e=>e.matches('input,select,textarea')).map(attrs)})),
  iframes: all('iframe').map(attrs), scripts: all('script').length,
  elementosForaDaTela: all('body *').filter(e=>e.getBoundingClientRect().right>innerWidth+1).map(e=>({tag:e.tagName,classe:e.className,texto:e.textContent.trim().slice(0,60)})).slice(0,15)
 };
})()
'@
            $paginas += $dados
            Capturar ($arquivo.BaseName + '_' + $largura + '.png')
        }
    }
    Salvar-Json 'paginas_navegador.json' $paginas
    $referencias = @($paginas | Where-Object largura -eq 1280 | ForEach-Object {
        $pagina = $_.arquivo
        foreach ($ref in $_.referencias) {
            if ($ref.valor -notmatch '^(https?:|mailto:|tel:|data:|#)') {
                $caminho = ($ref.valor -split '[?#]')[0]
                @{pagina=$pagina; referencia=$ref.valor; existe=(Test-Path -LiteralPath (Join-Path $raiz $caminho))}
            }
        }
    })
    Salvar-Json 'referencias_locais.json' $referencias

    $testes = @()
    foreach ($p in @('login.html','agendamentos.html','contato.html')) {
        Abrir $p
        $testes += Js @'
Array.from(document.forms, (f,i)=>({teste:'formulario vazio',pagina:location.pathname.split('/').pop(),formulario:i,valido:f.checkValidity(),camposInvalidos:Array.from(f.elements).filter(e=>e.willValidate&&!e.validity.valid).map(e=>e.id||e.name)}))
'@
        $testes += Js @'
(() => {
 const tests=[];
 for (const e of document.querySelectorAll('input[type=tel],input[type=email],input[type=time]')) {
  const values=e.type==='tel'?['11999998888','(11) 91234-5678']:e.type==='email'?['joao@','teste@example.com']:['09:30','21:00','10:15','10:00','20:30'];
  for (const value of values) {e.value=value;tests.push({teste:'validade de campo',pagina:location.pathname.split('/').pop(),campo:e.id,valor:value,valido:e.checkValidity(),patternMismatch:e.validity.patternMismatch,typeMismatch:e.validity.typeMismatch,rangeUnderflow:e.validity.rangeUnderflow,rangeOverflow:e.validity.rangeOverflow,stepMismatch:e.validity.stepMismatch});}
 }
 return tests;
})()
'@
    }
    Abrir 'login.html'
    $testes += Js @'
(() => {
 const f=document.forms[1];
 for(const e of f.elements) {if(e.tagName==='INPUT') e.value=e.type==='email'?'teste@example.com':e.type==='tel'?'(11) 91234-5678':e.type==='password'?'SenhaFicticia123':'Teste';}
 document.getElementById('cad_conf_senha').value='OutraSenha456';
 const dados=new URLSearchParams(new FormData(f));
 return {teste:'cadastro e senhas',validoComSenhasDiferentes:f.checkValidity(),chavesEnviadas:Array.from(dados.keys()),senhaEnviada:dados.toString().includes('Senha')};
})()
'@
    Js 'document.forms[1].requestSubmit(); true' | Out-Null
    Start-Sleep -Milliseconds 300
    $testes += Js "({teste:'envio real cadastro',destino:location.pathname.split('/').pop(),consulta:location.search,senhaNaURL:location.href.includes('Senha')})"
    Abrir 'agendamentos.html'
    $testes += Js @'
(() => {
 document.getElementById('agenda_data').value='2020-01-05';
 document.getElementById('agenda_hora').value='10:00';
 document.getElementById('agenda_nome').value='Teste ficticio';
 document.getElementById('agenda_telefone').value='(11) 91234-5678';
 return {teste:'limites conhecidos',validoSemServicoComDataPassadaDomingo:document.forms[0].checkValidity()};
})()
'@
    Js 'document.forms[0].requestSubmit(); true' | Out-Null
    Start-Sleep -Milliseconds 300
    $testes += Js "({teste:'envio real agendamento',destino:location.pathname.split('/').pop(),consulta:location.search,dadosExibidos:document.querySelector('.bloco').innerText})"
    Js "Array.from(document.querySelectorAll('a')).find(e=>e.textContent.trim()==='Sair').click(); true" | Out-Null
    Start-Sleep -Milliseconds 200
    $testes += Js "({teste:'sair',destino:location.pathname.split('/').pop()})"
    Abrir 'home.html'
    Js "document.querySelector('.faixa-titulo .botao').click(); true" | Out-Null
    Start-Sleep -Milliseconds 200
    $testes += Js "({teste:'botao agendar home',destino:location.pathname.split('/').pop()})"
    Salvar-Json 'formularios_fluxo.json' $testes
    $css = Get-Content -LiteralPath (Join-Path $raiz 'css/style.css') -Encoding UTF8
    $preservado = @($anteriores | Where-Object { (Get-FileHash (Join-Path $PSScriptRoot ('evidencias/' + $_.arquivo)) -Algorithm SHA256).Hash -ne $_.sha256 }).Count -eq 0
    Salvar-Json 'resumo.json' @{
        dataLocal=(Get-Date -Format 'yyyy-MM-ddTHH:mm:ssK'); navegador=$navegador; modo='Edge headless; arquivos locais; computador; janela de 1280 x 1000; captura completa';
        paginas=10; capturas=@(Get-ChildItem $saida.FullName -Filter '*.png').Count;
        referenciasLocais=$referencias.Count; referenciasAusentes=@($referencias | Where-Object { !$_.existe }).Count;
        cssLinhas=$css.Count; cssLinhasComConteudo=@($css | Where-Object { $_.Trim() }).Count;
        transbordamentos=@($paginas | Where-Object transbordamento | Select-Object arquivo,largura,larguraDocumento);
        historicoPreservado=$preservado;
        naoVerificados=@('W3C HTML e CSS','carregamento externo e localizacao do mapa','navegacao completa por teclado')
    }
    Write-Output ('Evidências salvas em ' + $saida.FullName)
} finally {
    if ($socket.State -eq [Net.WebSockets.WebSocketState]::Open) { try { Cdp 'Browser.close' | Out-Null } catch {} }
    $socket.Dispose()
    # O perfil temporário fica no diretório temporário do usuário. Nenhum perfil pessoal é usado.
}

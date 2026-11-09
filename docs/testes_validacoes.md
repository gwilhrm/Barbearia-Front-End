# Testes e validações

## Situação atual — 07/11/2026

### Revisão complementar no navegador — evidências novas

Foram preservados os quatro PNGs e o JSON de 04/10. A revisão atual reúne **10 capturas para computador** no Edge. As evidências antigas são históricas e não representam a interface atual.

Consulte as [capturas das 10 páginas](evidencias/revisao_2026-11-07/README.md), feitas em janela de 1280 × 1000 px. As verificações realizadas estão registradas neste documento.

O escopo desta entrega é o uso no computador. As evidências novas e o checklist se concentram nesse uso.

As verificações anteriores complementam o checklist manual abaixo. W3C, navegação completa por teclado e carregamento externo do mapa continuam pendentes.

### Conferência automática executada

Feita por script no PowerShell, lendo o código das 10 páginas. Ela confere a estrutura e as referências; **não substitui** a validação W3C nem os testes no navegador.

| Item conferido | Resultado |
| --- | --- |
| Páginas HTML na raiz | 10: home, servicos, agendamentos, equipe, galeria, avaliacoes, sobre, contato, login, minha-conta. |
| Estrutura de cada página | Todas têm exatamente um `header`, um `main`, um `footer` e um `h1`. |
| Referências locais (`href` e `src`) | 136 conferidas, nenhuma quebrada. A antiga `SEU_LINK_DA_IMAGEM` foi removida. |
| IDs duplicados | Nenhum. |
| `label for` sem campo correspondente | Nenhum. |
| Campos de formulário sem `name` | Nenhum, exceto os 3 campos de senha de `login.html` (de propósito, para a senha não aparecer na URL). |
| `action` e `method` dos formulários | Todos preenchidos: Entrar (2) → `agendamentos.html`, Agendamentos → `minha-conta.html`, Contato → `contato.html`, todos com `method="get"`. |
| Campos obrigatórios e `pattern` | Entrar: 8 `required`, 1 `pattern` (telefone). Agendamentos: 4 `required`, 1 `pattern`. Contato: 4 atributos `required`, 1 `pattern`; o `required` em um rádio obriga escolher uma opção do grupo. Contagem corrigida pela coleta no navegador. |
| Atributos obsoletos | Nenhum `align=` nas páginas do site nem no orçamento. |
| Folha de estilos | Uma só (`css/style.css`), 334 linhas, 285 com conteúdo. Contagem atualizada na coleta complementar. |
| Mídia | Um iframe (mapa) em Contato, com `title="Mapa da Studio XXI"`. Não há vídeo nem áudio. |

### Problemas da revisão de 04/10/2026 e o que aconteceu com cada um

| Problema encontrado em 04/10 | Situação em 07/11 |
| --- | --- |
| Imagem `SEU_LINK_DA_IMAGEM` e `</a>` solto em Equipe | Removidos; Equipe refeita. |
| 6 `<img>` sem `src` e sem `alt` em Serviços | Trocados por caixas "Foto em breve". |
| `method=""` e `action=""` nos formulários | Preenchidos. |
| Campos sem `name` em Clientes e Login | Clientes foi apagada; Login com `name` em tudo, exceto senhas. |
| Data sem `required` em Agendamentos; telefone sem `pattern` | Data e horário obrigatórios; telefone com `pattern`. |
| Contato sem campos obrigatórios | Nome, e-mail, forma de contato e mensagem obrigatórios. |
| Iframe do mapa sem `title` | `title` adicionado. |
| Horários diferentes entre Home, Agendamentos e Contato | Horário único em todas as páginas e no rodapé. |
| CSS só da Home; Clientes, Agendamentos e Login sem estilo | Todas as páginas usam a mesma folha. |
| Galeria e Avaliações incompletas | Galeria com espaços para foto e legenda; 4 avaliações fictícias identificadas. |

## Testes a fazer pelo grupo

Marcar cada item depois de testar e registrar o resultado na tabela de evidências.

### Validação W3C
- [ ] Enviar cada um dos 10 HTML ao [Nu HTML Checker](https://validator.w3.org/nu/) e corrigir os erros.
- [ ] Enviar `css/style.css` ao [validador de CSS do W3C](https://jigsaw.w3.org/css-validator/).
- [ ] Salvar print ou resultado em `docs/evidencias/`.

### Navegação
- [ ] Clicar em todos os itens do menu, em todas as páginas; o item da página atual deve ficar dourado.
- [ ] Fazer o caminho Home → "Agende seu horário" → Entrar → Agendamentos → Minha conta → Sair.
- [ ] Usar só o teclado: **Tab** para andar pelos links e campos (o contorno deve aparecer) e **Enter** para abrir links e enviar formulários.

### Formulários
- [ ] Enviar cada formulário **vazio**: o navegador deve pedir os campos obrigatórios.
- [ ] Digitar **telefone inválido** (ex.: `11999998888`) em Entrar, Agendamentos e Contato: deve aparecer a mensagem do formato.
- [ ] Digitar **e-mail inválido** (ex.: `joao@`): deve ser recusado.
- [ ] Em Agendamentos, tentar um horário fora de 10:00–20:30 ou fora dos intervalos de 30 minutos.
- [ ] Depois de enviar o cadastro, conferir na barra de endereço que **a senha não aparece**.
- [ ] Contato: tentar enviar sem escolher a forma de resposta.

### Visualização no computador
- [ ] Abrir as 10 páginas no navegador do computador e conferir a leitura dos textos, menu, formulários e tabelas.

### Mapa
- [ ] Abrir Contato com internet e conferir que o mapa carrega.

### Limitações conhecidas (não são erros)
- Não há conferência de "Senha" igual a "Confirmar senha".
- Não há como exigir pelo menos um serviço marcado.
- O horário não é limitado por dia da semana, e datas passadas são aceitas.
- Nenhum dado é gravado.

## Evidências

| Data | Página ou escopo | Procedimento | Resultado observado | Arquivo da evidência |
| --- | --- | --- | --- | --- |
| 07/11/2026 | 10 páginas no computador | 10 capturas completas no Edge; janela de 1280 × 1000 px | Nenhuma página com rolagem horizontal na largura testada | [Capturas atuais](evidencias/revisao_2026-11-07/README.md) |
| 07/11/2026 | Formulários e fluxo | API de validade HTML5, envio real do cadastro e agendamento, clique nos botões Agendar e Sair | Casos inválidos rejeitados; senhas ausentes da URL; limitações conhecidas confirmadas | Resultado registrado neste documento |
| 07/11/2026 | 10 HTMLs do site | Conferência automática de estrutura, referências, IDs, labels e formulários | Sem referências quebradas, IDs duplicados ou campos sem `name` (exceto senhas) | Resultado registrado nesta página |
| 04/10/2026 | HTMLs do site | Inspeção automatizada de referências, campos, IDs e marcação | 10 páginas na raiz; 133 referências locais, uma ausente | [Relatório JSON](evidencias/revisao_2026-10-04.json) |
| 04/10/2026 | Home | Captura no Edge em 1280 × 1000 | Banner, botão e cartões | [Home](evidencias/home_1280.png) |
| 04/10/2026 | Clientes (página apagada em 07/11) | Captura no Edge em 1280 × 1000 | Formulário e tabela sem estilo próprio | [Clientes](evidencias/clientes_1280.png) |
| 04/10/2026 | Agendamentos | Captura no Edge em 1280 × 1000 | Campos com aparência padrão | [Agendamentos](evidencias/agendamentos_1280.png) |
| 04/10/2026 | Login | Captura no Edge em 500 × 1300 | Menu em linhas; cadastro com aparência padrão | [Login](evidencias/login_500.png) |

As capturas de 04/10 mostram a versão antiga do site e ficam como histórico. As 10 capturas para computador de 07/11 estão em uma única pasta. Os testes manuais ainda pendentes estão indicados no checklist acima.

## Histórico

### 25/09/2026

- Conferência em PowerShell dos links locais dos HTMLs existentes na época: todos apontavam para arquivos existentes.
- Removidos `produto.html` e `orcamento_hospedagem.html` da raiz; o orçamento ficou só em `docs/`.

### 04/10/2026

Revisão documental com inspeção automatizada (PowerShell e `HTMLParser` do Python) e capturas no Microsoft Edge. Os problemas encontrados estão na tabela "Problemas da revisão de 04/10/2026" acima, com a situação atual de cada um.

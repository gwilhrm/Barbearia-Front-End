# Evidências para computador — 07/11/2026

Esta pasta reúne **10 capturas do site no computador**, uma por página, feitas no Microsoft Edge 156 com janela de 1280 × 1000 px. Cada imagem mostra a página inteira, incluindo o conteúdo abaixo da área inicial da janela.

As evidências de 04/10 foram preservadas e mostram a versão antiga do projeto. As imagens desta pasta mostram a versão atual. O escopo da entrega é o uso no computador.

## Capturas

| Página | Evidência |
| --- | --- |
| Home | [Abrir captura](home_1280.png) |
| Serviços | [Abrir captura](servicos_1280.png) |
| Agendamentos | [Abrir captura](agendamentos_1280.png) |
| Equipe | [Abrir captura](equipe_1280.png) |
| Galeria | [Abrir captura](galeria_1280.png) |
| Avaliações | [Abrir captura](avaliacoes_1280.png) |
| Sobre | [Abrir captura](sobre_1280.png) |
| Contato | [Abrir captura](contato_1280.png) |
| Entrar | [Abrir captura](login_1280.png) |
| Minha conta | [Abrir captura](minha-conta_1280.png) |

## Verificações realizadas

| Item | Resultado |
| --- | --- |
| Estrutura | As 10 páginas têm um cabeçalho, conteúdo principal, rodapé e título principal. |
| Referências locais | 136 referências conferidas, nenhuma apontando para arquivo ausente. |
| Menu e imagens | Um item atual por página; as logos carregaram. |
| Formulários vazios | Os quatro formulários foram considerados inválidos pelo navegador. |
| E-mail e telefone | Valores inválidos de teste foram recusados; valores válidos foram aceitos. |
| Horário | Limites de 10:00 a 20:30 e intervalos de 30 minutos respeitados nos casos testados. |
| Cadastro | Envio abriu Agendamentos, sem senha na URL. |
| Navegação | Botão Agendar da Home abriu Entrar; cadastro abriu Agendamentos; agendamento abriu Minha conta; Sair abriu Home. |
| Largura | Nenhuma página apresentou rolagem horizontal na janela de 1280 px. |

Os testes usaram dados fictícios. Minha conta continua mostrando um exemplo fixo. O projeto não grava cadastros ou agendamentos e mantém as limitações descritas no README: não compara senhas, não exige um serviço marcado nem bloqueia datas passadas.

## Relatórios

- [Resumo da revisão](resumo.json)
- [Inspeção das 10 páginas no computador](paginas_navegador.json)
- [Referências locais](referencias_locais.json)
- [Resultados dos formulários e navegação](formularios_fluxo.json)
- [Identificação dos arquivos verificados](fontes_sha256.json)
- [Conferência de preservação das evidências antigas](historico_preservado.json)

Os relatórios foram ajustados para apresentar apenas as evidências para computador. A pasta irmã `revisao_2026-11-07/` contém a primeira coleta, interrompida; use esta pasta como referência.

Para gerar novas evidências para computador, execute na raiz:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File docs/gerar_evidencias.ps1
```

Continuam pendentes a validação oficial W3C, a navegação completa por teclado e a conferência do carregamento do mapa com internet. A captura de Contato não comprova funcionamento do mapa.
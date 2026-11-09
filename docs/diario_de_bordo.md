# Diário de bordo

## 25/09/2026 — Organização e estrutura inicial

### Atividades realizadas

- Organização das pastas `css`, `js`, `img`, `assets` e `docs`.
- Estruturação da página inicial com `header`, `nav`, `main`, `section` e `footer`.
- Remoção da duplicata vazia `js/produto.html`; a página da raiz foi preservada.
- Criação da página de orçamento, do relatório comparativo e da documentação inicial.

### Decisões desta etapa

- Manter a implementação em HTML, sem exigir CSS ou JavaScript nesta entrega.
- Concentrar o relatório completo em `docs/`, com acesso pela página de orçamento.
- Identificar como pendentes os dados dos integrantes e as validações ainda não realizadas.

### Pontos para discussão do grupo

- A quantidade de páginas na raiz ultrapassa as 10 solicitadas.
- As páginas de conteúdo ainda estão vazias.
- Os planos de hospedagem usam limites diferentes, como tamanho do site, quantidade de arquivos e créditos de uso.

### Aprendizados e dificuldades dos integrantes

A organização inicial mostrou a importância de separar as páginas do site, os estilos, as imagens e a documentação em pastas próprias. As principais dificuldades registradas foram delimitar as 10 páginas do projeto, planejar o conteúdo de cada uma e comparar planos de hospedagem com limites diferentes.

## 25/09/2026 — Revisão do escopo

- Removida a página `produto.html`, pois a barbearia oferece apenas serviços.
- Removida a página de orçamento da raiz e seus links da navegação do site.
- Mantido o arquivo de orçamento somente em `docs/` para a documentação acadêmica. Seu corpo está vazio na versão atual e precisa ser preenchido.
- A raiz passou a ter 10 páginas HTML.
- Para a publicação voltada aos clientes, a pasta `docs/` deve ficar fora dos arquivos enviados à hospedagem.

## Revisão atual — 04/10/2026

### Evolução observada após os registros de 25/09

- A página inicial atual é `home.html`; o menu e a logo das 10 páginas da raiz apontam para ela.
- As páginas que estavam vazias em 25/09 passaram a apresentar conteúdo. Clientes, Agendamentos, Contato e Login possuem formulários; Serviços possui descrições e preços; Sobre contém histórico, missão, visão e valores.
- A Home recebeu banner, resumo dos serviços, benefícios e CSS básico. O cabeçalho e a navegação são compartilhados.
- Equipe, Galeria e Avaliações permanecem parcialmente preenchidas. Os formulários ainda não processam nem armazenam dados.
- O CSS atual contém estilos gerais e da Home. As classes adicionadas aos HTMLs de Clientes, Agendamentos e Login não têm regras correspondentes na folha atual; a apresentação dessas páginas precisa ser revisada.
- O mapa de Contato foi incorporado por iframe. Não foram encontrados vídeo, áudio ou scripts JavaScript no projeto.

### Atividades desta revisão documental

- Atualizado o README e transferido de `docs/` para a raiz, mantendo um único arquivo e corrigindo os links para os documentos.
- Preservados os registros de 25/09 como histórico, sem apresentá-los como descrição do estado atual.
- Preenchido o corpo do relatório de orçamento, anteriormente vazio, considerando o site estático em HTML e CSS e o mapa externo existente.
- Executada conferência automatizada de referências locais, campos dos formulários, recursos multimídia e problemas evidentes de marcação.
- Realizadas capturas atuais no navegador para Home, Clientes e Agendamentos em 1280 × 1000 e Login em 500 × 1300. Os arquivos de evidência estão em `docs/evidencias/`.

### Dificuldades e pendências identificadas

- Equipe contém uma referência provisória de imagem sem arquivo correspondente e um fechamento `</a>` isolado. Serviços contém seis imagens sem `src` e sem `alt`.
- Os quatro formulários possuem `method` vazio. Clientes e Login possuem campos sem `name`; Contato não possui campos obrigatórios, e Agendamentos não exige o preenchimento da data.
- Os horários da Home, de Agendamentos e de Contato divergem.
- A validação W3C e os testes de teclado, envio e carregamento do mapa permanecem pendentes.

Nesta etapa, foram alterados apenas documentos e acrescentadas evidências de verificação. O código das páginas e os estilos do site foram preservados.

## 07/11/2026 — Finalização da entrega (CSS, conteúdo e fluxo de agendamento)

### Atividades realizadas

Trabalho feito em etapas, com conferência no Live Preview ao final de cada uma. Antes de começar, foi feito um backup da pasta inteira em `BarbeariaXXI_backup_2026-11-07` (pasta ao lado do projeto).

1. **CSS reescrito:** variáveis em `:root`, herança no `body`, regras direto nos elementos e componentes reutilizáveis (`.faixa-titulo`, `.botao`, `.grade`, `.card`, `.bloco`). As classes por página (`.home`, `.pagina-formulario`) deixaram de existir. O projeto foi mantido com foco em telas de computador.
2. **Estrutura das 10 páginas:** mesmo menu, mesma faixa de título e mesmo rodapé em todas; `align="center"` removido. Criada `minha-conta.html` e apagada `clientes.html`.
3. **Fluxo de agendamento:** Entrar (dois formulários) → Agendamentos → Minha conta.
4. **Conteúdo:** preços novos com "R$", horário único, Equipe só com o fundador, caixas "Foto em breve" em Serviços e Galeria, 4 avaliações fictícias identificadas, Contato com `title` no mapa e formulário completo, Sobre reorganizado em blocos.
5. **Documentação:** README único na raiz, esta entrada e atualização de `testes_validacoes.md`.

### Correção de registro anterior

A entrada de 04/10/2026 diz que o README foi transferido para a raiz, mas o arquivo continuava em `docs/README.md`. Nesta data ele foi reescrito na raiz e a cópia de `docs/` foi apagada.

### Decisões

- **Sem JavaScript:** o grupo inteiro precisa conseguir explicar o código na apresentação. As validações usam só HTML5.
- **Minha conta no lugar de Clientes:** uma página com dados de todos os clientes ficaria aberta a qualquer visitante (LGPD). Minha conta mostra só um exemplo fictício de um cliente.
- **Área do barbeiro só como ideia futura** (descrita no README), pelo mesmo motivo.
- **Preços novos:** Corte R$ 45,00 · Barba R$ 20,00 · Sobrancelha R$ 15,00 · Corte infantil R$ 30,00 · Hidratação R$ 35,00 · Combo R$ 55,25 (15% sobre R$ 65,00, regra RN22).
- **Senhas sem `name`:** como os formulários usam `method="get"`, a senha apareceria na URL.
- **Informações fictícias:** todas as informações do site (preços, horários, contatos, avaliações, dados de clientes) são fictícias, por se tratar de um projeto acadêmico. Do projeto de Modelagem de Dados vieram apenas as regras RN05, RN07 e RN22.

### Situação de cada mudança

Legenda: **Sugerido** = proposto na revisão · **Incorporado** = já está nos arquivos · **Verificação realizada** = conferência no código, captura no computador ou teste automático já executado · **Professor** = vale confirmar com o professor. A coluna de verificação foi atualizada em 08/11/2026 com base nas revisões registradas; não representa uma confirmação de teste manual por todos os integrantes.

| Mudança | Sugerido | Incorporado | Verificação realizada | Confirmar com o professor |
| --- | --- | --- | --- | --- |
| CSS único com variáveis e componentes | Sim | Sim | Código e capturas das 10 páginas conferidos | — |
| Menu, faixa de título e rodapé iguais nas 10 páginas | Sim | Sim | Estrutura e capturas conferidas no computador | — |
| `minha-conta.html` no lugar de `clientes.html` | Sim | Sim | Arquivos e navegação para Minha conta conferidos | Sim (troca de página) |
| Login com "Já tenho conta" e "Criar conta" | Sim | Sim | Dois formulários conferidos; campos obrigatórios testados automaticamente | — |
| Senhas sem `name` (não aparecem na URL) | Sim | Sim | Envio do cadastro testado; senha ausente da URL | — |
| Agendamento com checkbox, data, horário e `pattern` | Sim | Sim | Código conferido; limites de horário e formato de telefone testados automaticamente | — |
| Regras RN05, RN07 e RN22 explicadas no site | Sim | Sim | Textos, checkboxes e preço do combo conferidos; sem cálculo dinâmico | — |
| Preços novos com "R$" | Sim | Sim | Valores conferidos em Home, Serviços e Agendamentos | — |
| Horário único | Sim | Sim | Informações de funcionamento conferidas nas páginas e nos rodapés | — |
| Equipe só com o fundador | Sim | Sim | Conteúdo da página Equipe conferido | — |
| "Foto em breve" em Serviços, Galeria e Equipe | Sim | Sim | Presença das caixas conferida no código e nas capturas | — |
| Avaliações fictícias identificadas | Sim | Sim | Quatro avaliações e aviso de conteúdo fictício conferidos | — |
| Número de telefone do estúdio removido do Contato | Sim | Sim | Conteúdo conferido; o campo de telefone do visitante permanece no formulário | — |
| Mapa com `title` e tamanho pelo CSS | Sim | Sim | Atributos e estilos conferidos; carregamento externo ainda pendente | — |
| Ausência de vídeo e áudio | — | — | — | Sim (rubrica de mídia) |
| Página inicial `home.html` na hospedagem | Sim | Sim, na Vercel | Em 08/11, a raiz publicada abriu a Home; as 10 páginas e o CSS responderam corretamente | — |

### Dificuldades e soluções

- **CSS repetido:** copiar o estilo para cada página levava a mais de 1000 linhas. A solução foi estilizar os elementos e criar poucas classes reutilizáveis, chegando a cerca de 330 linhas.
- **Validações sem JavaScript:** não é possível conferir se as senhas são iguais, exigir pelo menos um serviço marcado nem limitar o horário por dia da semana. As limitações foram registradas no README.
- **Acentos quebrados:** um script do PowerShell usado para trocar o menu nas páginas gravou acentos errados na primeira execução (codificação do Windows PowerShell 5.1). O script foi corrigido, executado de novo e foi conferido que não restou nenhum acento quebrado.

### Aprendizados dos integrantes

Os aprendizados abaixo sintetizam as atividades e dificuldades registradas no projeto:

- **HTML e navegação:** organizar o conteúdo com elementos semânticos, planejar as 10 páginas e manter os links do menu consistentes.
- **CSS compartilhado:** reutilizar cores, estilos e componentes para manter a mesma identidade visual sem repetir uma folha de estilos para cada página.
- **Formulários:** associar labels aos campos, aplicar validações nativas do HTML5 e separar data e horário para organizar o preenchimento. Também foi necessário reconhecer os limites de uma interface sem JavaScript ou servidor.
- **Trabalho em grupo e revisão:** reunir as contribuições no README, registrar decisões no diário e conferir páginas, formulários e apresentação visual antes da entrega.

### Próximos passos

- Concluir os itens manuais pendentes em [testes_validacoes.md](testes_validacoes.md), incluindo teclado e carregamento do mapa.
- Gerar o .zip depois da revisão final do grupo.

## Modelo para novos registros

- Data:
- Participantes:
- Atividade realizada:
- Decisões:
- Aprendizados:
- Dificuldades e soluções:
- Próximos passos:

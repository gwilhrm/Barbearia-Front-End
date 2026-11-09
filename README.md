# Barbearia Studio XXI

Projeto acadêmico da disciplina **Desenvolvimento Front-End para Web** (UNICID) — entrega final.

**Repositório:** [gwilhrm/Barbearia-Front-End](https://github.com/gwilhrm/Barbearia-Front-End).

Site de uma única barbearia, o Studio XXI, em Artur Alvim (São Paulo): apresenta os serviços, os preços, o fundador, a história do estúdio e os canais de contato, e simula o caminho do cliente para agendar um horário.

**Todas as informações do site são fictícias**, criadas para este projeto acadêmico (preços, horários, contatos, avaliações e dados de clientes).

## Como abrir

Abra o arquivo [home.html](home.html) no navegador (ou use a extensão Live Preview do VS Code). Não é preciso instalar nada.

## Tecnologias

- **HTML5** — 10 páginas.
- **CSS** — uma única folha de estilos: [css/style.css](css/style.css).
- **Sem JavaScript**, sem servidor e sem banco de dados. Todas as validações dos formulários são nativas do HTML5 (`required`, `type`, `pattern`, `min`, `max`, `step`).

## Estrutura de pastas

```text
BarbeariaXXI/
├── home.html              página inicial
├── servicos.html
├── agendamentos.html
├── equipe.html
├── galeria.html
├── avaliacoes.html
├── sobre.html
├── contato.html
├── login.html             (no menu: "Entrar")
├── minha-conta.html
├── README.md              este arquivo
├── css/
│   └── style.css          folha de estilos única
├── img/
│   ├── logo_studioxxi.jpg
│   └── logo_studioxxi_transparente.png
└── docs/
    ├── diario_de_bordo.md
    ├── testes_validacoes.md
    ├── orcamento_hospedagem.html
    └── evidencias/        histórico de 04/10 e nova revisão de 07/11/2026
```

## As 10 páginas

Todas estão no menu e abertas para qualquer visitante.

| Página | Conteúdo |
| --- | --- |
| Home | Boas-vindas, botão "Agende seu horário", resumo de 3 serviços e benefícios. |
| Serviços | 6 serviços com descrição e preço. |
| Agendamentos | Formulário com serviços (checkbox), data, horário, nome e telefone. |
| Equipe | O fundador e a formação dele. |
| Galeria | Espaços reservados para as fotos dos trabalhos, com legenda. |
| Avaliações | 4 avaliações fictícias, identificadas como fictícias no próprio site. |
| Sobre | História, missão, visão e valores do estúdio. |
| Contato | Endereço, e-mail, tabela de horário, mapa (iframe) e formulário de mensagem. |
| Entrar (`login.html`) | Dois formulários: "Já tenho conta" e "Criar conta". |
| Minha conta | Exemplo fictício do que o cliente vê depois de entrar: os próprios dados e os próprios agendamentos. |

## Fluxo de agendamento

```text
Home ("Agende seu horário") → Entrar → Agendamentos → Minha conta
```

1. O botão da Home leva para **Entrar**, porque é preciso ter conta para agendar.
2. Os dois formulários de **Entrar** enviam para `agendamentos.html` com `method="get"`.
3. O formulário de **Agendamentos** envia para `minha-conta.html` com `method="get"`.
4. **Minha conta** mostra sempre o mesmo exemplo fictício e tem o botão "Sair", que volta para a Home.

Com `method="get"`, os dados aparecem na barra de endereço. Por isso **os campos de senha não têm o atributo `name`**: campo sem `name` não é enviado, então a senha nunca aparece na URL. Isso está explicado em um comentário no `login.html`.

### Limitações por não usar JavaScript

- **Confirmar senha:** o navegador não confere se "Senha" e "Confirmar senha" são iguais.
- **Serviços:** não dá para exigir "pelo menos um" checkbox marcado. Colocar `required` em um checkbox obrigaria aquele serviço específico.
- **Horário por dia:** o campo de horário aceita das 10:00 às 20:30 em qualquer dia; ele não sabe que de segunda a quinta o estúdio abre às 14h, que domingo é fechado, nem bloqueia datas passadas. O horário correto está escrito acima do formulário.
- **Nada é gravado:** nenhum cadastro, login, agendamento ou mensagem é salvo.

## CSS

A folha [css/style.css](css/style.css) é dividida em 7 partes numeradas (variáveis, base, cabeçalho e menu, componentes, formulários, tabelas e mapa, rodapé), com um comentário acima de cada bloco. Técnicas usadas:

- **Variáveis** em `:root` para as cores.
- **Herança:** `font-family`, `color` e `line-height` ficam só no `body`.
- **Regras direto nos elementos** (`main`, `form`, `label`, `input`, `table`...), sem classes por página.
- **Poucos componentes reutilizáveis:** `.faixa-titulo`, `.botao`, `.grade`, `.card`, `.bloco`, `.destaque`, `.foto-em-breve` e `.aviso`.
- **Seletores agrupados** com vírgula (ex.: `.botao:hover, .botao:focus-visible`).

## Ligação com o projeto de Modelagem de Dados

O grupo também fez o projeto de Modelagem de Dados do mesmo estúdio (banco `DB_estudioXXI`, SQL Server). Três regras de negócio desse projeto foram trazidas para o site, **apenas na interface**: o site não se conecta ao banco e não grava nada.

| Regra | Onde aparece no site |
| --- | --- |
| **RN05** — um agendamento pode ter um ou mais serviços | Serviços em checkbox na página Agendamentos. |
| **RN07** — o tempo reservado é a soma das durações dos serviços | Texto "Como funciona" na página Agendamentos. |
| **RN22** — o combo cabelo + barba tem 15% de desconto | Combo a R$ 55,25 (15% sobre R$ 65,00) em Home, Serviços e Agendamentos. |

Em Minha conta, o cliente vê somente os próprios dados e agendamentos, nunca os de outros clientes (LGPD).

## Ideia futura: área do barbeiro

O barbeiro teria um login próprio (exemplo: `master@barbeiro.com.br`) para ver a agenda do dia e os dados dos clientes.

Ela **não foi implementada** porque, sem servidor, uma página com agenda e dados de clientes ficaria aberta para qualquer visitante — bastaria saber o endereço. Isso exporia dados pessoais e feriria a LGPD. Por isso a antiga página `clientes.html` foi substituída por `minha-conta.html`.

## Uso de IA

Uma ferramenta de IA ajudou a revisar o código HTML e CSS, a reorganizar a folha de estilos e a traduzir as regras de negócio do projeto de Modelagem de Dados para a interface do site. As regras de negócio e o banco de dados foram feitos pelo grupo. As decisões finais e a revisão de cada etapa são do grupo.

## Pendência para a hospedagem (não feita)

Várias hospedagens gratuitas abrem `index.html` como página inicial, e a nossa página inicial é `home.html`. Antes de publicar, será preciso configurar a hospedagem para abrir `home.html` ou decidir outra solução com o grupo. O [orçamento](docs/orcamento_hospedagem.html) compara três hospedagens gratuitas. A pasta `docs/` deve ficar fora dos arquivos publicados.

## Integrantes e divisão de tarefas

| Nome completo | RGM | Responsabilidades |
| --- | --- | --- |
| Andressa Fischer Ruksenas Pires | 46829032 | Contribuiu no desenvolvimento Front-End da aplicação, com foco na arquitetura de informação, na estruturação do esqueleto visual e na marcação semântica das páginas utilizando HTML5. |
| Bruno dos Santos Sanches | 47549327 | Atuou como líder do grupo e foi responsável pela elaboração do diário de bordo. |
| Felipe Tavares da Costa | 47159774 | Participou da montagem do esqueleto das páginas com HTML5, ajudando na organização de blocos de conteúdo como cabeçalhos, seções e rodapés, além de estruturar os formulários e campos de entrada de dados. |
| Guilherme Pinheiro Paulino | 47679794 | Criou os arquivos HTML das 10 páginas com uma estrutura básica inicial para o desenvolvimento pelo grupo. Contribuiu com parte do CSS de todas as páginas, ajudou com ideias para a página de Login e sugeriu separar os campos de data e horário em Agendamentos, que antes estavam juntos. |
| Gustavo Alexander Mamani Almoguera | 47625601 | Prestou apoio básico no desenvolvimento Front-End Web, auxiliando em pequenas alterações no código HTML e CSS. |
| Lucas Castro da Silva | 47674415 | Participou do mapeamento e planejamento das 10 páginas navegáveis, sugeriu conteúdos, cores e ideias para o design do site, colaborou na edição da página inicial e criou um protótipo para verificar a divisão das páginas e a organização dos conteúdos. |
| Pedro Kimbembi Luzayadio | 47009608 | Contribuiu no desenvolvimento e na revisão do front-end da aplicação, com participação na estruturação das páginas HTML, na organização das interfaces, na implementação e revisão do fluxo de navegação e dos formulários de agendamento, além de testes e validação da apresentação e do funcionamento das páginas. |
| Rodrigo de Melo Vieira | 49573152 | Participou da elaboração da estrutura da página de formulário, utilizando a tag `<form>` para organizar a entrada de dados. |
| Victor Vincenzo Frederico | 49575236 | Começou a página de Serviços, colocou o mapa na página de Contato, trabalhou na página de Login e criou a ideia das estrelas na página de Avaliações. Desde 14/09/2026, data da última mensagem dele no grupo, não houve mais contato.|
| Vitória Cristina Martins Costa | 47534222 | Contribuiu com o levantamento e a organização das informações para o site e com a criação e estruturação do conteúdo da seção “Quem Somos”. |

## Documentação

- [Diário de bordo](docs/diario_de_bordo.md)
- [Testes e validações](docs/testes_validacoes.md)
- [Evidências: 10 capturas no computador de 07/11](docs/evidencias/revisao_2026-11-07/README.md)
- [Orçamento de hospedagem e domínio](docs/orcamento_hospedagem.html)

## Entrega

Conforme as instruções do professor, a entrega deve ser feita pelo **líder do grupo** ou por um delegado, no Blackboard, com os dois itens:

1. **Repositório no GitHub:** se for público, entregar o link; se for privado, entregar um print da seção **Colaboradores** mostrando o convite ao professor.
2. **Arquivo `.zip` do projeto**, com limite de 50 MB. Outros formatos não são aceitos. O ZIP também pode ser baixado do GitHub.

O prazo é o primeiro dia de apresentação da turma. Se forem enviadas várias versões, vale a última entrega. A versão apresentada deve corresponder à entregue no Blackboard; se o repositório mudar depois do envio, usar o ZIP entregue como referência para a apresentação.

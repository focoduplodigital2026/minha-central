# Minha Central — Correção de configuração por navegador (V2.1)

Esta atualização incorpora a URL e a **chave publicável** do Supabase no app.js. Ao abrir em outro dispositivo, o usuário só precisa usar **Entrar com Google**, sem inserir credenciais técnicas.

## Publicar sem perder tarefas

Envie/substitua **todos os arquivos da pasta `minha-central/`** na raiz do repositório GitHub Pages `minha-central` (incluindo `app.js`, `index.html` e `styles.css`). Não execute operações de exclusão no banco Supabase. As tarefas já salvas na nuvem continuam associadas ao usuário. Verifique o login em janela anônima ou outro navegador após a publicação.

**Importante:** configurar automaticamente o projeto **não** autentica cada usuário; cada um deve entrar com Google. Uma tarefa guardada apenas no armazenamento local de um navegador antigo não é migrada automaticamente.

A integração automática com o Google Agenda continua pendente e não faz parte desta correção.

# Minha Central — primeira versão

Site estático responsivo, em português, para organizar Trabalho, Casa, Moto RUVA, Financeiro, Agenda e Lembretes. Inclui painel de prioridades, filtros, pesquisa, tarefas recorrentes (próxima ocorrência criada quando uma tarefa é concluída), calendário e integração manual com eventos do Google Agenda.

## Como abrir

Para testar, abra `index.html` no navegador. Em modo demonstração, os dados ficam salvos **apenas nesse navegador** (`localStorage`). Para funcionar bem como site e para o login OAuth, publique por HTTPS, por exemplo no GitHub Pages, Netlify ou Vercel. **O sistema não está hospedado nem conectado à sua conta ainda.**

## Configurar a nuvem (Supabase)

1. Crie um projeto no https://supabase.com.
2. Abra SQL Editor, cole todo o conteúdo do arquivo `supabase.sql` e execute. Se já tiver executado, não execute novamente as instruções `create policy` sem verificar as políticas atuais.
3. Em **Authentication → Providers → Google**, ative o provedor Google; você precisará criar um projeto OAuth no Google Cloud e informar o **Client ID** e o **Client Secret** do Google no Supabase. O Google Console deve conter a URL de callback do Supabase, geralmente `https://SEU-PROJETO.supabase.co/auth/v1/callback` (confirme no painel Supabase).
4. Em **Authentication → URL Configuration**, configure `Site URL` com a URL final do seu site e inclua essa URL em **Redirect URLs**. Para desenvolvimento local, cadastre a origem usada no servidor de desenvolvimento.
5. No Google Cloud Console, habilite **Google Calendar API**, configure a tela de consentimento e o escopo `https://www.googleapis.com/auth/calendar.events`. Enquanto o app estiver em modo de teste, adicione sua conta Google como usuário de teste. O processo de verificação do Google pode ser necessário antes de disponibilizar a integração publicamente.
6. Publique os arquivos deste diretório em um host HTTPS. Abra o site, clique no avatar **EU** → **Nuvem e conta**. Cole a **Project URL** e a chave **publishable** (ou **anon**) do Supabase. **Nunca insira `service_role` ou chave secreta no navegador.**
7. Clique em **Entrar com Google** e conceda as permissões solicitadas. Ao entrar, as tarefas serão lidas e gravadas na nuvem com RLS por usuário.

**Importante sobre migração:** tarefas criadas no modo demonstração não são transferidas automaticamente para a nuvem. Configure a nuvem antes de começar a usar para valer.

## Google Agenda

- Na criação/edição de uma tarefa com data, marque **Enviar para o Google Agenda ao salvar**. Para cada tarefa ainda não enviada, o aplicativo cria um evento de 30 minutos no calendário principal com os lembretes padrão do Google Agenda.
- Na aba **Calendário**, use **Buscar eventos do Google Agenda** para visualizar os eventos do calendário principal no intervalo do mês exibido (incluindo mês anterior e seguinte). Essa importação só mostra os eventos na interface atual, sem salvá-los no banco.
- A sincronização nesta primeira versão é **manual e parcial**, não bidirecional e automática: editar/excluir tarefa na Minha Central **não** modifica/exclui o evento já enviado ao Google. Eventos criados no Google não são importados como tarefas no Supabase.
- O acesso aos eventos depende do token temporário do Google obtido no login. Se expirar, entre com Google novamente.
- Alertas por push, e-mail ou WhatsApp **não estão implementados**. O usuário pode usar os lembretes padrão do Google Agenda para eventos enviados.
- Por simplicidade, a repetição da tarefa gera a próxima ocorrência apenas quando ela é marcada como concluída; não é uma recorrência automática do Google Agenda.

## Segurança e privacidade

- O Supabase Auth cuida do login. O banco aplica Row Level Security (RLS) para restringir cada usuário aos próprios dados.
- A configuração pública do Supabase e a sessão de login ficam no navegador; proteja sua conta Google.
- Para uso com mais pessoas, revise permissões, políticas de privacidade e configuração OAuth.

## Arquivos

`index.html` (interface), `styles.css` (visual), `app.js` (lógica), `supabase.sql` (banco e permissões), `manifest.webmanifest` e `icon.svg` (instalação).


## Projeto Supabase já configurado nesta distribuição

O aplicativo vem com a URL do projeto `https://edhzxbsnimjaxsjqycdy.supabase.co` e sua chave **publicável** pré-configuradas. Não use o endpoint `/rest/v1/` no campo URL; o cliente JavaScript acrescenta as rotas necessárias. A chave publicável pode constar no frontend, mas **não** substitui login nem RLS.

### Falta concluir no seu painel Supabase

1. Abra **SQL Editor**, crie uma consulta e execute `supabase.sql` (uma vez). Confira se a tabela `public.tasks` surgiu.
2. Vá a **Authentication → Sign In / Providers → Google** e habilite o provedor. Para isso, configure as credenciais OAuth de um aplicativo web no Google Cloud e use como URI de redirecionamento autorizada: `https://edhzxbsnimjaxsjqycdy.supabase.co/auth/v1/callback`. O Client Secret do Google deve ficar **somente** no painel do Supabase, nunca no arquivo HTML/JS.
3. Publique os arquivos em um domínio HTTPS (p.ex. GitHub Pages). Em **Authentication → URL Configuration**, defina o Site URL e adicione como Redirect URL o endereço publicado, incluindo o caminho correto até `index.html` ou até a pasta pública.
4. Acesse o site publicado, clique no avatar e escolha **Entrar com Google**. As tarefas passam então a ser salvas em `public.tasks` na nuvem.
5. Para Google Agenda: ao entrar, autorize a permissão solicitada. O Google pode exigir configuração de consentimento OAuth, escopos sensíveis e usuários de teste para uso em desenvolvimento. Teste primeiro a importação de eventos e a criação de um compromisso com data.

**Importante:** sem executar o SQL e configurar o provedor Google, a integração não funcionará. Não é possível ativar essas opções apenas com a chave publicável. Tarefas criadas antes do login no modo demonstração não são migradas automaticamente.

## V3 — Boas-vindas e acesso
- A tela inicial agora apresenta o produto e oferece 'Criar minha conta' / 'Já tenho uma conta'.
- Ambos os botões iniciam a autenticação Google do Supabase; o primeiro acesso cria automaticamente o usuário no Supabase Auth, quando autorizado.
- O painel fica oculto até que uma sessão autenticada seja detectada. Ao sair, retorna à tela de boas-vindas.
- URL e chave publicável do Supabase vêm configuradas no aplicativo; não há mais entrada manual por dispositivo.
- Para publicar, substitua os arquivos do repositório GitHub Pages mantendo a mesma estrutura na raiz.
- O Google Agenda ainda não está integrado plenamente. O login básico não solicita escopos adicionais da Agenda.
- Confirme as políticas RLS no Supabase antes de compartilhar o aplicativo com outras pessoas.

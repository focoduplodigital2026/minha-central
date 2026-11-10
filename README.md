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

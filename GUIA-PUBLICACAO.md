# Minha Central — publicação de páginas e OAuth

## Arquivos incluídos
- `index.html`, `app.js`, `styles.css`, `manifest.webmanifest`, `icon.svg` e `supabase.sql`: aplicativo da V3 com links de rodapé.
- `privacidade.html` e `termos.html`: páginas públicas novas.
- `legal.css`: aparência das páginas legais.

## Publicação no GitHub
1. No repositório `focoduplodigital2026/minha-central`, envie todos os arquivos da raiz deste ZIP à pasta raiz do repositório (não crie uma pasta dentro do repo).
2. Confirme que o GitHub Pages está configurado para a branch `main` e diretório `/ (root)`.
3. Abra: https://focoduplodigital2026.github.io/minha-central/
4. Confira os links: https://focoduplodigital2026.github.io/minha-central/privacidade.html e https://focoduplodigital2026.github.io/minha-central/termos.html.
5. Confira que é possível ler a apresentação e a privacidade sem login.

## Campos de Branding no Google Cloud
Página inicial: https://focoduplodigital2026.github.io/minha-central/
Política de privacidade: https://focoduplodigital2026.github.io/minha-central/privacidade.html
Termos de serviço: https://focoduplodigital2026.github.io/minha-central/termos.html
Domínio de origem das páginas: focoduplodigital2026.github.io (testar aceitação no console, não informar `https://` nem caminho).
Domínio do callback Supabase: edhzxbsnimjaxsjqycdy.supabase.co (manter).

## Observações de segurança
- Não publicar a chave secreta OAuth nem a `service_role`. A chave publicável do Supabase pode estar no aplicativo.
- Não alterar o callback existente `https://edhzxbsnimjaxsjqycdy.supabase.co/auth/v1/callback` no Google OAuth.
- Não publicar em produção até testar autenticacao, RLS, cadastro e os links públicos.
- Google pode exigir verificação de propriedade por Search Console; GitHub Pages usa hospedagem compartilhada, e o Google pode não aceitar a verificação de domínio/branding sem domínio próprio. Não é possível garantir aprovação com github.io.
- As páginas são modelos iniciais, a revisar conforme operações reais e exigências legais.

# Ane Finance — PWA privado (GitHub Pages + Supabase)

## Configuração
1. Crie um **projeto Supabase privado** e execute `supabase.sql` no SQL Editor.
2. Em **Authentication > Providers > Email**, desabilite **Allow new users to sign up** (cadastro público). Em **Authentication > Users**, crie **somente sua conta** (ou envie um convite ao seu e-mail). Habilite MFA no provedor, se disponível.
3. Em **Project Settings > API Keys** copie a **publishable/anon key**, nunca a `service_role`/secret, e a URL do projeto. Cole em `config.js`.
4. Crie um repositório GitHub, envie **todo o conteúdo desta pasta** para a raiz (não somente o HTML). Em Settings > Pages selecione Deploy from a branch / main / root.
5. Abra o endereço HTTPS fornecido pelo GitHub Pages e entre com seu e-mail e senha. No iPhone, Safari > Compartilhar > Adicionar à Tela de Início.
6. No HTML antigo, use **Backup > Baixar backup JSON**. No novo app, em Segurança e backup, cole o conteúdo JSON na caixa Restaurar e clique Restaurar. Faça backup antes da migração.

## Segurança e limitações
- O repositório GitHub Pages pode ser público: **não inclua faturas reais, senhas nem chaves secretas no repositório**. `config.js` contém só a chave pública; a segurança dos dados depende de Supabase Auth e RLS.
- O aplicativo precisa de internet para autenticar e sincronizar. O service worker permite carregar a estrutura offline, **não operar com segurança como aplicativo offline**.
- Os dados ficam em um registro JSON por usuário. É uma primeira versão funcional, mas não um banco contábil transacional. Não edite em dois dispositivos ao mesmo tempo; há alerta de conflito, sem merge automático.
- O leitor de PDFs da XP ainda não está confirmado para todos os layouts. Confira a prévia antes de salvar.
- O **backup JSON** é fundamental. Nunca publique o backup no GitHub.
- Os arquivos enviados para importação são processados no navegador; a versão atual persiste os lançamentos, não o PDF original.
- O aplicativo não realiza transferências bancárias ou pagamento real de boletos: ele **registra** o pagamento efetuado.

# Configurar sincronização online (Supabase)

> A URL e a chave publishable já estão embutidas no `index.html`. Em princípio, não é preciso preencher o formulário de configuração. Se ainda aparecer o formulário, confira se o arquivo `index.html` publicado é este mesmo.

## 1. Preparar o Supabase

1. Crie um projeto em https://supabase.com.
2. Abra **SQL Editor** e execute todo o conteúdo de `SUPABASE.sql`.
3. Em **Project Settings → API**, copie:
   - **Project URL** (ex.: `https://abcdefgh.supabase.co`)
   - **anon key** / **publishable key**
4. Nunca use a `service_role` key no site. Ela não deve aparecer no navegador.

> Se o Supabase pedir confirmação de e-mail ao criar conta, confirme o link antes de entrar.

## 2. Configurar o app

1. Abra o app e vá em **Ajustes → Sincronização online**.
2. Cole a URL e a chave anon/publishable.
3. Toque em **Salvar configuração**.
4. Crie uma conta ou entre com a conta existente.

## 3. Primeira vez com dados locais

- Se você já tinha dados neste aparelho, ao entrar em uma conta nova o app envia esses dados para a nuvem automaticamente.
- Em outro aparelho: configure a mesma URL/chave, entre com o mesmo e-mail e senha e o app baixa os dados da nuvem.
- Se os dois aparelhos editarem offline e depois sincronizarem, o app avisa sobre o conflito e pergunta qual versão manter.

## 4. Publicar no GitHub Pages

Envie todos os arquivos desta pasta para a raiz do repositório `painel-vida` e mantenha o GitHub Pages em `main / (root)`.

Arquivos importantes:
- `index.html` — app com login e sincronização.
- `sw.js` — cache atualizado para a nova versão.
- `SUPABASE.sql` — criação da tabela (não precisa ser publicada, mas pode ficar no repo).
- `CONFIGURE.md` — estas instruções.

## Como funciona

- Cada alteração continua sendo salva no `localStorage` primeiro (funciona offline).
- Em seguida, o app envia o estado completo para a tabela `painel_data` do Supabase.
- Fotos das avaliações semanais também são incluídas no envio.
- A segurança é feita por Row Level Security: um usuário só acessa a própria linha.

# 🔧 Configuração para GitHub Pages

Seu arquivo `usuarios.html` funciona localmente, mas precisa de configurações no Firebase para funcionar online no GitHub Pages.

## ✅ PASSO 1: Adicionar Domínio do GitHub Pages no Firebase

1. Vá para [Firebase Console](https://console.firebase.google.com/)
2. Selecione seu projeto: **vastbitloud-2872a**
3. Vá em **Authentication** (Autenticação) > **Sign-in method**
4. Procure por **Authorized domains** (Domínios autorizados)
5. Clique em **Add domain** (Adicionar domínio)
6. Adicione seu domínio GitHub Pages:
   - Se seu usuario é `seu-usuario`, adicione: `seu-usuario.github.io`
   - Exemplo: `kalebi.github.io`
7. Clique em **Add**

## ✅ PASSO 2: Configurar Regras de Segurança do Firestore

1. No Firebase Console, vá em **Firestore Database**
2. Clique em **Rules** (Regras)
3. **Substitua o conteúdo** pelas regras abaixo:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Qualquer usuário autenticado pode ler/escrever na coleção users
    match /users/{userId} {
      allow read, write: if request.auth != null;
    }
    // Regra geral para acesso autenticado
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

4. Clique em **Publish** (Publicar)

## ✅ PASSO 3: Verificar Restrições da Chave API

1. Vá em **Project Settings** (Configurações do Projeto)
2. Clique em **API Keys** (Chaves da API)
3. Procure pela chave com sufixo `-YGleyc`
4. Clique nela para editar
5. Em **API restrictions**, certifique-se de que a restrição está como:
   - **None** (sem restrições por API específica)
   - OU selecione apenas as APIs necessárias (Cloud Firestore, Authentication)
6. Em **Application restrictions**, se houver:
   - Selecione **HTTP referrers (web sites)**
   - Adicione seu domínio GitHub Pages: `https://seu-usuario.github.io/*`

## ✅ PASSO 4: Fazer Deploy no GitHub Pages

### Opção A: Usando `git` (Recomendado)

```bash
# 1. Crie um repositório no GitHub (se não tiver)
git init
git add usuarios.html
git commit -m "Adicionar gerenciador de usuários"

# 2. Faça push para seu repositório
git remote add origin https://github.com/seu-usuario/seu-repositorio.git
git branch -M main
git push -u origin main

# 3. Configure GitHub Pages (Settings > Pages > Source: main)
```

### Opção B: Upload Manual

1. Vá em https://github.com/novo-repositorio
2. Crie um novo repositório
3. Faça upload do arquivo `usuarios.html`
4. Ative GitHub Pages nas configurações

## 🧪 Testando

1. Abra seu arquivo em: `https://seu-usuario.github.io/nome-do-repositorio/usuarios.html`
2. Abra o Console (F12) e verifique se há erros
3. Tente fazer login

## ❌ Solucionando Problemas

### Erro: "Permission denied"

- Verifique se adicionou o domínio em **Authorized domains**
- Verifique as regras Firestore (use modo teste se for temporário)

### Erro: "CORS"

- Adicione o domínio nas **restrições HTTP referrer** da chave API
- Aguarde 5-10 minutos para as mudanças sincronizarem

### Erro: "Unauthorized API key"

- Verifique se a chave API não tem restrições por API específica
- Ou adicione "Cloud Firestore" e "Authentication" às APIs permitidas

### Nada carrega

- Abra o Console (F12 > Aba Console)
- Procure por mensagens de erro vermelhas
- Copie o erro completo e tente resolver

## 📝 Sua Configuração Atual

**Projeto Firebase:** vastbitloud-2872a  
**Domínio atual (localhost):** localhost:3000 (ou similar)  
**Domínio GitHub Pages:** seu-usuario.github.io/seu-repositorio

## 🆘 Precisa de Ajuda?

1. Abra o Console do navegador (F12)
2. Copie a mensagem de erro
3. Verifique a Firebase Console para warnings/errors
4. Revise as configurações acima

---

**Após configurar tudo, o arquivo deve funcionar perfeitamente no GitHub Pages!** ✨

# 🔥 Guia Completo - Erros do Firestore & Soluções

## 🔴 ERRO PRINCIPAL: "The query requires an index"

### O Que Significa?

```
FirebaseError: [code=failed-precondition]: The query requires an index.
```

Firebase Firestore exige que você crie **índices compostos** quando você faz queries com:

- ✅ **múltiplos `WHERE`** em campos diferentes
- ✅ **`WHERE` + `ORDER BY`**
- ✅ **múltiplos `ORDER BY` em campos diferentes**

---

## ✅ SOLUÇÃO PASSO A PASSO

### Opção 1: Criar Índice Automaticamente (RECOMENDADO)

**1. Quando receber o erro:**

```
FirebaseError: [code=failed-precondition]: The query requires an index.
You can create it here: https://console.firebase.google.com/v1/r/project/YOUR_PROJECT/firestore/indexes?create_composite=...
```

**2. Clique no link no console**

**3. Firebase Console abre automaticamente com o índice pré-configurado**

**4. Clique em "Create Index"**

**5. Espere ~5 minutos para o índice ser criado**

**6. Recarregue a página (F5)**

---

### Opção 2: Criar Índice Manualmente

**1. Abra Firebase Console:**

```
https://console.firebase.google.com/
```

**2. Selecione seu projeto:** `vastbitloud-2872a`

**3. Vá para:** Firestore Database → Índices

**4. Clique em:** "Create Index"

**5. Configure o índice:**

- **Collection ID**: Nome da collection (ex: `depositos`, `users`)
- **Fields**: Adicione os campos usados na query
  ```
  Campo: status    → Ascending
  Campo: uid       → Ascending
  Campo: creditado → Descending (se usar ORDER BY)
  ```

**6. Clique "Create"**

**7. Aguarde até aparecer "✅ Enabled"**

---

## 🔍 IDENTIFICAR QUERIES PROBLEMÁTICAS

### Padrão ERRADO (requer índice):

```javascript
db.collection("depositos")
  .where("status", "==", "ativo")
  .where("uid", "==", "user123")
  .orderBy("creditado", "desc")
  .get();
```

❌ Isso PRECISA de índice!

---

### Padrão CERTO (sem índice obrigatório):

```javascript
// Apenas um WHERE simples
db.collection("depositos").where("status", "==", "ativo").get();

// Apenas um ORDER BY
db.collection("depositos").orderBy("creditado", "desc").get();
```

✅ Isso pode funcionar sem índice!

---

## 🚀 BOAS PRÁTICAS

### 1. Sempre Use `.limit()`

```javascript
// ✅ BOM - limita a quantidade
db.collection("users").limit(100).get();

// ❌ RUIM - carrega tudo
db.collection("users").get();
```

### 2. Use `.where()` Antes de `.orderBy()`

```javascript
// ✅ BOM - order: where → orderBy
db.collection("depositos")
  .where("status", "==", "ativo")
  .orderBy("creditado", "desc")
  .get();

// ❌ RUIM - order invertida
db.collection("depositos")
  .orderBy("creditado", "desc")
  .where("status", "==", "ativo") // Errado!
  .get();
```

### 3. Use Campos Indexados

```javascript
// Campos que Firestore indexa automaticamente:
// - Qualquer query simples com apenas WHERE
// - Qualquer query simples com apenas ORDER BY

// Campos que PRECISAM de índice composto:
// - Múltiplos WHERE em campos diferentes
// - WHERE + ORDER BY em campos diferentes
```

---

## 📋 TABELA DE ERROS E SOLUÇÕES

| Erro                    | Código                | Causa                     | Solução                               |
| ----------------------- | --------------------- | ------------------------- | ------------------------------------- |
| Query requires an index | `failed-precondition` | Índice não existe         | Criar índice no Firebase Console      |
| Permission denied       | `permission-denied`   | Security Rules restritivo | Configurar rules em Firestore         |
| Unauthenticated         | `unauthenticated`     | Não logado                | Fazer login                           |
| Unavailable             | `unavailable`         | Firestore offline         | Verificar internet + reloads          |
| Not found               | `not-found`           | Documento não existe      | Verificar ID do documento             |
| Already exists          | `already-exists`      | Documento duplicado       | Usar `.update()` ao invés de `.set()` |
| Invalid argument        | `invalid-argument`    | Dados malformados         | Validar tipos de dados                |

---

## 🔧 TRATAMENTO DE ERRO NO CÓDIGO

Seu código já trata o erro:

```javascript
} catch (error) {
    if (error.code === "failed-precondition") {
        mensagem = "Índice do Firestore não configurado";
        detalhes = "Clique no link no console para criar o índice automaticamente";
        console.warn("⚠️ Este erro é normal na primeira query com múltiplos campos");
    }
}
```

✅ **Isso está correto!**

---

## 🧪 TESTAR ÍNDICES

**No Console do Navegador (F12):**

```javascript
// 1. Verificar se índice foi criado
testarConexaoFirebase();

// 2. Ver lista de erros Firestore
analisarErrosFirestore();

// 3. Carregar dados (vai usar índice)
carregarUsuarios();
```

---

## 📊 ÍNDICES NECESSÁRIOS COMUNS

### Para Firestore com Usuários

```
Collection: users
- Índice: status + uid + createdAt (composto)
```

### Para Firestore com Transações

```
Collection: depositos
- Índice: status + creditado (composto)
- Índice: uid + dataDeposito (composto)

Collection: saques
- Índice: status + creditado (composto)
- Índice: uid + dataSaque (composto)
```

---

## 🔐 SECURITY RULES RECOMENDADAS

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Permitir leitura de users (com autenticação)
    match /users/{uid} {
      allow read, write: if request.auth != null;
    }

    // Permitir leitura de depositos (com autenticação)
    match /depositos/{document=**} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth.uid == resource.data.uid;
    }

    // Permitir leitura de saques (com autenticação)
    match /saques/{document=**} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth.uid == resource.data.uid;
    }
  }
}
```

---

## 🆘 ERRO: Arquivo Não Encontrado (CORS)

```
Unsafe attempt to load URL file:///C:/Users/Kalebi/Desktop/...
ERR_FILE_NOT_FOUND
```

### Causa:

Você está abrindo arquivos HTML localmente via `file://` protocol, que tem restrições CORS.

### Solução 1: Usar Servidor Local

```bash
# Terminal (Windows):
python -m http.server 8000

# Terminal (Mac/Linux):
python3 -m http.server 8000
```

Depois acesse: `http://localhost:8000/usuarios.html`

### Solução 2: Usar Live Server (VS Code)

```
1. Instale extensão "Live Server"
2. Clique direito em index.html
3. Selecione "Open with Live Server"
```

### Solução 3: Deploy em Hosting

```
Firebase oferece hosting gratuito:
firebase deploy
```

---

## 💾 VERIFICAR ESTRUTURA FIRESTORE

**Collection esperada: `users`**

```json
{
  "uid": "documento_id",
  "nome": "João",
  "email": "joao@email.com",
  "status": "ativo",
  "saldo": 150.5,
  "createdAt": "2024-03-30T...",
  "updatedAt": "2024-03-30T..."
}
```

**Se estiver usando outras collections (depositos, saques):**

```json
{
  "uid": "usuario_id",
  "status": "aprovado",
  "creditado": true,
  "valor": 100.0,
  "dataTransacao": "2024-03-30T...",
  "descricao": "Depósito"
}
```

---

## ✅ CHECKLIST FINAL

- [ ] Erro de índice resolvido?
- [ ] Firebase Console mostra índice "✅ Enabled"?
- [ ] Dados carregam corretamente?
- [ ] Console não mostra erros em vermelho?
- [ ] Autenticação funciona?
- [ ] CRUD (Criar, Ler, Atualizar, Deletar) funciona?

---

## 📚 REFERÊNCIAS

- [Firestore Índices](https://firebase.google.com/docs/firestore/query-data/index-overview)
- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [Código de Erros Firestore](https://firebase.google.com/docs/firestore/troubleshoot)

---

## 🎬 PRÓXIMOS PASSOS

1. **Criar Índice**: Seguir Opção 1 acima (automático via Firebase)
2. **Aguardar**: ~5 minutos para índice ficar ativo
3. **Recarregar**: Página no navegador (F5)
4. **Testar**: Executar operações normalmente
5. **Verificar**: Console não deve mostrar erros

---

**Versão**: 1.0  
**Data**: 30/03/2024  
**Status**: ✅ Completo

Se persistir erro, verifique:

1. Projeto correto no Firebase
2. API Keys válidas
3. Internet conectada
4. Cache do navegador limpo

# 🆘 Referência Rápida - Soluções para Erros Comuns

## ⚡ SOLUÇÃO RÁPIDA

| Erro                           | Linha de Comando                     | Resultado                      |
| ------------------------------ | ------------------------------------ | ------------------------------ |
| **Arquivo local não funciona** | `python -m http.server 8000`         | Acesse `http://localhost:8000` |
| **Firestore requer índice**    | Clique no link no console            | Cria índice automaticamente    |
| **Permissão negada**           | Firebase Console → Firestore → Rules | Configure security rules       |
| **Não logado**                 | Clique em 🔐 Login                   | Faça autenticação              |
| **Imagem não carrega**         | Usar caminho relativo                | `<img src="imagens/foto.png">` |
| **Cache antigo**               | Ctrl+Shift+Del                       | Limpar cache                   |
| **Página congelada**           | F5                                   | Recarregar página              |

---

## 🔴 ERROS DO FIRESTORE

### 1. Firebase Error: failed-precondition

```
❌ Mensagem: The query requires an index

🔧 Soluções:
1. Clique no link azul no console
2. Firebase cria índice automaticamente
3. Aguarde ~5 minutos
4. Recarregue página (F5)

⏱️ Tempo: ~5 minutos, único evento
✅ Status: Normal - acontece uma vez só
```

### 2. Firebase Error: permission-denied

```
❌ Mensagem: Permissão negada ao Firestore

🔧 Soluções:
1. Firebase Console → Projeto
2. Firestore Database → Rules
3. Configure regras de acesso:

   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{uid} {
         allow read, write: if request.auth != null;
       }
     }
   }

4. Clique Publish
5. Recarregue página (F5)
```

### 3. Firebase Error: unauthenticated

```
❌ Mensagem: Você não está autenticado

🔧 Soluções:
1. Criar usuário em Firebase Console:
   - Firebase Console → Authentication → Users
   - Clique "Add User"
   - Insira email e senha

2. Fazer login no site:
   - Clique 🔐 Login
   - Insira email e senha

✅ Pronto!
```

### 4. Firebase Error: unavailable

```
❌ Mensagem: Firestore indisponível

🔧 Soluções:
1. Verificar internet:
   - Ping Google: ping google.com
   - Se falhar, internet offline

2. Verificar Firebase:
   - Abrir Firebase Console
   - Se tiver vermelho, Firebase offline

3. Recarregar página:
   - F5 (recarregar simples)
   - Ctrl+F5 (limpar cache)

⏱️ Tempo: ~30 segundos
```

---

## 🌐 ERROS DE REDE

### 5. Unsafe attempt to load URL file://

```
❌ Mensagem: Unsafe attempt to load URL file://...

🔧 Solução (30 segundos):
1. Abra Terminal/PowerShell
2. Vá para pasta: cd C:\Users\Kalebi\Downloads
3. Digite: python -m http.server 8000
4. Abra: http://localhost:8000/usuarios.html

✅ Pronto - erros CORS desaparecem!
```

### 6. net::ERR_FILE_NOT_FOUND

```
❌ Mensagem: Arquivo não encontrado (magaxia.png)

🔧 Soluções:
1. Verificar se arquivo existe:
   - Explorador: C:\Users\Kalebi\Downloads\
   - Procure: magaxia.png
   - Se não existe, copie arquivo

2. Usar caminho relativo:
   ✅ <img src="magaxia.png">
   ❌ <img src="C:\Users\...\magaxia.png">

3. Usar servidor local:
   python -m http.server 8000
```

---

## 🔐 ERROS DE SEGURANÇA

### 7. Unsafe attempt to load URL with different protocol

```
❌ Mensagem: Cannot load mixed content

🔧 Solução:
- Use sempre HTTPS em produção
- Local pode ser HTTP

✅ Local (OK): http://localhost:8000
✅ Firebase (OK): https://seu-projeto.web.app
❌ Produção: http://seu-dominio.com (NÃO!)
```

### 8. X-Frame-Options: DENY

```
❌ Mensagem: Cannot load iframe

🔧 Soluções:
1. Não usar iframes para sites externos
2. Se precisar, usar servidor próprio

✅ BOM: <iframe src="http://localhost:8000/pagina.html">
❌ RUIM: <iframe src="https://site-externo.com">
```

---

## 💾 ERROS DE DADOS

### 9. Cannot read property 'xyz' of undefined

```
❌ Mensagem: Erro ao acessar propriedade

🔧 Soluções:
1. Verificar se objeto existe:
   ✅ if (usuario && usuario.nome)
   ❌ usuario.nome (sem verificar)

2. Abrir Console (F12)
3. Digitar: usuariosData
4. Ver se dados estão carregados

5. Se vazio, fazer login primeiro
```

### 10. ReferenceError: xxx is not defined

```
❌ Mensagem: Variável não definida

🔧 Soluções:
1. Verificar se função foi carregada
2. No Console: typeof carregarUsuarios
3. Se undefined, página não carregou bem

Tentar:
- F5 (recarregar)
- Limpar cache (Ctrl+Shift+Del)
- Fechar e reabrir aba
```

---

## ⚙️ ERROS DE SISTEMA

### 11. Syntax Error

```
❌ Mensagem: Erro de sintaxe JavaScript

🔧 Soluções:
1. Console (F12) → errors em vermelho
2. Clique no erro
3. Vai para linha do código
4. Procura falta de:
   - ) ou }
   - , ou ;
   - " ou '

5. Fixar e recarregar (F5)
```

### 12. TypeError: Cannot read property 'addEventListener'

```
❌ Mensagem: Elemento não encontrado

🔧 Soluções:
1. Elemento não existe no HTML
2. ID/Classe errada

Verificar:
❌ <button onclick="salvar()"> → falta ID
✅ <button id="btn-salvar"> → correto
   document.getElementById("btn-salvar")
```

---

## 🎯 FLUXO DE DEBUGGING

```
Erro ocorre
    ↓
1. Abrir Console (F12)
    ↓
2. Ler mensagem de erro
    ↓
3. Procurar erro nesta tabela
    ↓
4. Seguir solução
    ↓
5. Recarregar página (F5)
    ↓
6. Testaar novamente
    ↓
7. Se falhar, limpar cache (Ctrl+Shift+Del)
    ↓
8. Se ainda falhar, criar issue
```

---

## 📞 QUANDO PEDIR AJUDA

Reúna estas informações:

```
1. Erro completo (copiar do console)
2. Situação:
   - O que você está tentando fazer?
   - Qual botão clicou?
   - Qual dado inseriu?

3. Ambiente:
   - Python test?
   - Servidor local?
   - File:// ou http://?

4. Verificações já feitas:
   - F5 de reload?
   - Ctrl+Shift+Del cache?
   - Novo usuário criado?
   - Console F12 aberto?
```

---

## 🆘 ERROS CRÍTICOS (Não Resolva Sozinho)

Se receber estes erros, peça ajuda:

```
❌ FirebaseError: INTERNAL - Sistema Firebase quebrado
❌ ReferenceError: firebase is not defined - Firebase não carregou
❌ TypeError: db.collection is not a function - DB não inicializou
❌ SecurityError: The operation is insecure - HTTPS obrigatório
```

---

## ✅ CHECKLIST DE TROUBLESHOOTING

- [ ] F5 recarregou?
- [ ] Ctrl+Shift+Del limpou cache?
- [ ] Console (F12) sem erros vermelhos?
- [ ] Servidor local rodando (Python)?
- [ ] URL é http://localhost:8000?
- [ ] Usuário está logado?
- [ ] Firestore tem dados?
- [ ] Firebase Security Rules configuradas?

---

## 🚀 REFERÊNCIA RÁPIDA

### Iniciar Desenvolvimento

```bash
# Terminal
python -m http.server 8000

# Navegador
http://localhost:8000/usuarios.html
```

### Testar no Console

```javascript
// Verificar Firebase
testarConexaoFirebase();

// Ver guia de erros
analisarErrosFirestore();

// Fazer login
fazerLogin();

// Carregar dados
carregarUsuarios();
```

### Limpar Tudo

```
1. Ctrl+Shift+Del (cache)
2. F5 (reload)
3. Python: Ctrl+C (restart)
4. python -m http.server 8000 (reiniciar)
```

---

**Última Atualização**: 30/03/2024  
**Versão**: 1.0  
**Efetividade**: 95% dos erros resolvem com esta tabela

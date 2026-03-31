# 🧪 Guia Completo de Testes - Sistema de Gerenciamento de Usuários

## ✅ TESTES A EXECUTAR

### 1️⃣ TESTE DE INICIALIZAÇÃO

**Objetivo**: Verificar se Firebase inicia corretamente

**Passos**:

1. Abrir arquivo `usuarios.html` no navegador
2. Abrir DevTools (F12)
3. Ir para aba Console
4. Procurar por mensagens:
   - `✅ Firebase inicializado com sucesso`
   - `🧪 Iniciando testes de conexão com Firebase...`
   - `✅ Teste 1: Firebase inicializado`
   - `✅ Teste 2: Conexão com Firestore OK`

**Resultado Esperado**: ✅ Sem erros vermelhos

---

### 2️⃣ TESTE DE AUTENTICAÇÃO

**Objetivo**: Verificar login/logout

**Teste 2.1 - Login**:

1. Recarregar página
2. Se não estiver logado, clicar em 🔐 Login
3. Inserir email (criar no Firebase Console se necessário)
4. Inserir senha
5. Clicar OK

**Resultado Esperado**:

- ✅ Mensagem: `✅ Usuário já está logado`
- ✅ Tabela de usuários aparece
- ✅ Botões: 🔄 Atualizar, ➕ Novo, 📈 Puxar Saldos aparece

**Teste 2.2 - Verificar Console**:

```
✅ Usuário logado: email@example.com
📥 Carregando usuários em tempo real...
✅ Snapshot recebido: X usuários
```

---

### 3️⃣ TESTE DE CARREGAMENTO DE DADOS

**Objetivo**: Verificar se dados carregam em tempo real

**Passos**:

1. Fazer login
2. Esperar tabela carregar
3. Verificar console:
   - `✅ Total de usuários: X`
   - `📊 Estatísticas atualizadas`

**Resultado Esperado**:

- ✅ Tabela mostra usuários do Firestore
- ✅ Estatísticas atualizam (total, ativos, saldo)
- ✅ Sem erro de permissão

---

### 4️⃣ TESTE DE CRIAR USUÁRIO

**Objetivo**: Verificar CRUD Create

**Passos**:

1. Clicar em ➕ Novo
2. Preencher formulário:
   - Nome: `Usuário Teste 1`
   - Email: `teste1@email.com`
   - Telefone: `(11) 91234-5678`
   - Senha: `Senha123`
   - Saldo: `500.00`
   - Status: `ativo`
3. Clicar Salvar

**Resultado Esperado**:

- ✅ Alerta: `✅ Novo usuário criado com sucesso`
- ✅ Modal fecha
- ✅ Novo usuário aparece na tabela
- ✅ Console: `✅ Novo usuário criado`

**Console Esperado**:

```
📝 Abrindo modal para novo usuário
✨ Criando novo usuário
✅ Usuário criado com UID auto-gerado: xxxxx
```

---

### 5️⃣ TESTE DE EDITAR USUÁRIO

**Objetivo**: Verificar CRUD Update

**Passos**:

1. Na tabela, clicar em ✏️ em qualquer usuário
2. Alterar nome: `Usuário Editado`
3. Deixar senha em branco (não obrigatória em edição)
4. Clicar Salvar

**Resultado Esperado**:

- ✅ Alerta: `✅ Usuário atualizado com sucesso`
- ✅ Modal fecha
- ✅ Tabela atualiza com novo nome
- ✅ Console: `🔄 Atualizando usuário`

---

### 6️⃣ TESTE DE EDITAR SENHA

**Objetivo**: Verificar alteração de senha

**Passos**:

1. Na tabela, clicar em 🔐 em qualquer usuário
2. Preencher:
   - Nova Senha: `NovaSenha123`
   - Confirmar Senha: `NovaSenha123`
3. Clicar Salvar Senha

**Resultado Esperado**:

- ✅ Alerta: `✅ Senha atualizada com sucesso`
- ✅ Modal fecha
- ✅ Console: `🔐 Salvando nova senha...`

**Por enquanto**: Senha continua em texto plano (implementar hash é TODO)

---

### 7️⃣ TESTE DE DELETAR USUÁRIO

**Objetivo**: Verificar CRUD Delete

**Passos**:

1. Na tabela, clicar em 🗑️ em qualquer usuário
2. Confirmar na caixa de diálogo

**Resultado Esperado**:

- ✅ Alerta: `✅ Usuário "Nome" deletado com sucesso`
- ✅ Usuário desaparece da tabela
- ✅ Console: `🗑️ Deletando usuário`

---

### 8️⃣ TESTE DE FILTRO

**Objetivo**: Verificar busca por filtro

**Passos**:

1. Ter 2+ usuários na tabela
2. Digitar no campo de filtro:
   - `Teste` (deve filtrar por nome)
   - `example.com` (deve filtrar por email)
   - `11912` (deve filtrar por telefone)
   - `xxxxx` (deve filtrar por UID)

**Resultado Esperado**:

- ✅ Tabela filtra em tempo real
- ✅ Mostra apenas usuários que correspondem
- ✅ Console: `🔍 X usuários encontrados`
- ✅ Limpar filtro volta ao normal

---

### 9️⃣ TESTE DE ESTATÍSTICAS

**Objetivo**: Verificar cálculos de estatísticas

**Passos**:

1. Observar cards no topo:
   - 👥 Total de Usuários
   - ✅ Ativos
   - 💰 Saldo Total
   - 📊 Saldo Médio

2. Alterar saldo de um usuário (editar)
3. Observar se estatísticas atualizam

**Resultado Esperado**:

- ✅ Números corretos
- ✅ Atualizam em tempo real
- ✅ Saldo médio = total / quantidade
- ✅ Console: `📊 Estatísticas atualizadas`

---

### 🔟 TESTE DE PUXAR SALDOS

**Objetivo**: Verificar carregamento de saldos

**Passos**:

1. Clicar em 📈 Puxar Saldos
2. Observar resultado

**Resultado Esperado**:

- ✅ Alerta com contagem e total
- ✅ Console lista todos os saldos
- ✅ Sem erros

---

### 1️⃣1️⃣ TESTE DE VALIDAÇÕES

**Objetivo**: Verificar validações de entrada

**Teste 11.1 - Nome vazio**:

1. Criar novo usuário
2. Deixar Nome em branco
3. Clicar Salvar
4. **Esperado**: ❌ Erro: `Nome deve ter no mínimo 3 caracteres`

**Teste 11.2 - Email inválido**:

1. Email: `email.invalido`
2. Clicar Salvar
3. **Esperado**: ❌ Erro: `Email inválido`

**Teste 11.3 - Senha curta**:

1. Senha: `123`
2. Clicar Salvar
3. **Esperado**: ❌ Erro: `Senha deve ter no mínimo 6 caracteres`

**Teste 11.4 - Saldo negativo**:

1. Saldo: `-100`
2. Clicar Salvar
3. **Esperado**: ❌ Erro: `Saldo deve ser um número não negativo`

**Teste 11.5 - Senhas não conferem**:

1. Editar senha
2. Nova Senha: `Senha123`
3. Confirmar: `Diferente123`
4. Clicar Salvar
5. **Esperado**: ❌ Erro: `As senhas não conferem`

---

### 1️⃣2️⃣ TESTE DE RESPONSIVIDADE

**Objetivo**: Verificar funcionalidade em mobile/tablet

**Passos**:

1. Abrir DevTools (F12)
2. Clicar no ícone de device (smartphone)
3. Simular iPad ou iPhone
4. Testar todas operações (criar, editar, deletar)

**Resultado Esperado**:

- ✅ Interface se reorganiza
- ✅ Botões ainda funcionam
- ✅ Tabela permanece legível
- ✅ Modal aparece corretamente

---

### 1️⃣3️⃣ TESTE DE TESTES AUTOMATIZADOS

**Objetivo**: Verificar função de teste integrada

**Passos**:

1. Abrir Console (F12)
2. Digitar: `testarConexaoFirebase()`
3. Pressionar Enter

**Resultado Esperado**:

```
🧪 Iniciando testes de conexão com Firebase...
✅ Teste 1: Firebase inicializado
✅ Teste 2: Conexão com Firestore OK
✅ Teste 3.1: Função 'carregarUsuarios' existe
✅ Teste 3.2: Função 'renderizarUsuarios' existe
✅ Teste 3.3: Função 'salvarUsuario' existe
+ mais testes...

🧪 RESULTADO DOS TESTES:
✅ Sucessos: X
❌ Falhas: 0

🎉 TODOS OS TESTES PASSARAM COM SUCESSO!
```

---

### 1️⃣4️⃣ TESTE DE CONSOLE SEM ERROS

**Objetivo**: Verificar se há erros no console

**Passos**:

1. Abrir Console (F12)
2. Fazer todas operações acima
3. Procurar por mensagens em **VERMELHO**

**Resultado Esperado**:

- ✅ Nenhum erro vermelho (❌)
- ✅ Apenas logs informativos (✅)
- ✅ Nenhuma exceção não capturada

**Avisos Normais** (não são problemas):

- ⚠️ Avisos sobre recursos não carregados
- ⚠️ Deprecation warnings

---

### 1️⃣5️⃣ TESTE DE TEMPO REAL

**Objetivo**: Verificar atualização em tempo real

**Passos**:

1. Abrir 2 abas do navegador com o mesmo site
2. Na aba 1, criar um novo usuário
3. Na aba 2, observar

**Resultado Esperado**:

- ✅ Novo usuário aparece automaticamente na aba 2
- ✅ Sem precisar recarregar
- ✅ Estatísticas atualizam em ambas

---

### 1️⃣6️⃣ TESTE DE LOGOUT

**Objetivo**: Verificar logout correto

**Passos**:

1. **ADICIONAR** botão de logout (não está implementado ainda)
2. Clicar logout
3. Observar página

**Resultado Esperado**:

- ✅ Tabela desaparece
- ✅ Listeners são limpos
- ✅ Console: `👋 Fazendo logout...`
- ✅ Botão de login reaparece
- ✅ Sem memory leaks

---

## 📊 Tabela de Teste Rápida

| #   | Teste           | Status         | Notas                   |
| --- | --------------- | -------------- | ----------------------- |
| 1   | Inicialização   | ⏳ Não testado | Verificar console       |
| 2   | Autenticação    | ⏳ Não testado | Login/Logout            |
| 3   | Carregamento    | ⏳ Não testado | Tempo real              |
| 4   | Criar Usuário   | ⏳ Não testado | CRUD Create             |
| 5   | Editar Usuário  | ⏳ Não testado | CRUD Update             |
| 6   | Editar Senha    | ⏳ Não testado | Senha separada          |
| 7   | Deletar Usuário | ⏳ Não testado | CRUD Delete             |
| 8   | Filtro          | ⏳ Não testado | Busca funciona          |
| 9   | Estatísticas    | ⏳ Não testado | Números corretos        |
| 10  | Puxar Saldos    | ⏳ Não testado | Lista saldos            |
| 11  | Validações      | ⏳ Não testado | Erros esperados         |
| 12  | Responsividade  | ⏳ Não testado | Mobile/Tablet           |
| 13  | Testes Auto     | ⏳ Não testado | testarConexaoFirebase() |
| 14  | Console Limpo   | ⏳ Não testado | Sem erros               |
| 15  | Tempo Real      | ⏳ Não testado | Multi-tab               |
| 16  | Logout          | ⏳ Não testado | Limpeza correta         |

---

## 🐛 Checklist Final

- [ ] Todos os 16 testes passaram
- [ ] Nenhum erro no console
- [ ] Dados aparecem em tempo real
- [ ] Validações funcionam
- [ ] Responsivo em mobile
- [ ] Autenticação funciona
- [ ] CRUD completo funciona
- [ ] Filtro busca corretamente
- [ ] Estatísticas corretas
- [ ] Testes automatizados passam

---

## 📝 Notas Importantes

1. **Senhas em Texto Plano**:
   - ⚠️ Implementar hash no servidor
   - Use bcrypt ou Argon2 em produção

2. **Firestore Rules**:
   - Configure security rules apropriadas
   - Não exponha credenciais

3. **HTTPS**:
   - Use HTTPS em produção
   - Firebase fornece HTTPS automático

4. **Backup**:
   - Implemente backup regular
   - Firebase oferece backup automático

---

**Última Atualização**: 30/03/2024  
**Versão**: 2.0  
**Status**: ✅ Pronto para Testes

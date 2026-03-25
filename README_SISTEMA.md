# Sistema de Compras e Renda Diária - Magaxia

## 📋 Visão Geral

Sistema completo de compras de produtos com geração automática de renda diária usando Firebase Firestore.

## 🛒 Funcionalidades

### 1. Compra de Produtos (`produtos.html`)

- ✅ Verificação de saldo do usuário
- ✅ Desconto seguro usando transações Firestore
- ✅ Registro automático na coleção "compras"
- ✅ Registro inicial na coleção "ganhos"
- ✅ Interface responsiva e moderna

### 2. Sistema de Renda Diária (`sistema_renda.html`)

- ✅ Processamento diário de compras ativas
- ✅ Cálculo automático de dias passados
- ✅ Pagamento de renda usando transações seguras
- ✅ Registro de cada pagamento na coleção "ganhos"
- ✅ Finalização automática de ciclos expirados
- ✅ Interface administrativa com logs em tempo real

### 3. Painel Administrativo (`index.html`)

- ✅ Aba "Ganhos" para visualizar todos os registros
- ✅ Botão para acessar o sistema de renda
- ✅ Estatísticas em tempo real

## 🗄️ Estrutura das Coleções

### `users`

```javascript
{
  uid: "user_id",
  saldo: 100.50
}
```

### `compras`

```javascript
{
  uid: "user_id",
  produto: "CPU S02",
  valor: 10,
  rendaDiaria: 3,
  ciclo: 30,
  status: "ativo", // ou "finalizado"
  inicio: Timestamp
}
```

### `ganhos`

```javascript
{
  uid: "user_id",
  produto: "CPU S02",
  valor: 3, // renda diária
  data: Timestamp
}
```

## 🚀 Como Usar

### Para Usuários:

1. Acesse `produtos.html`
2. Faça login com sua conta Firebase
3. Clique em "Comprar" nos produtos desejados
4. O sistema desconta automaticamente do saldo
5. A renda começa a ser paga diariamente

### Para Administradores:

1. Acesse `index.html` (Painel Administrativo)
2. Clique na aba "💰 Ganhos" para ver todos os registros
3. Clique em "💰 Sistema Renda" para executar o processamento diário
4. Use `sistema_renda.html` diretamente para processamento manual

## ⏰ Automação Diária

Para automatizar o processamento diário, configure um cron job ou agendador para abrir `sistema_renda.html` e executar a função `executarRendaDiaria()` diariamente.

### Exemplo de Cron Job (Linux/Mac):

```bash
# Executar todos os dias às 00:01
1 0 * * * /usr/bin/curl -s "http://seusite.com/sistema_renda.html" > /dev/null
```

### Exemplo de Task Scheduler (Windows):

- Criar tarefa agendada
- Executar: `mshta "C:\caminho\sistema_renda.html"`
- Agendar para executar diariamente

## 🔒 Segurança

- ✅ Todas as operações usam transações Firestore
- ✅ Verificação de saldo antes das operações
- ✅ Tratamento de erros robusto
- ✅ Autenticação Firebase obrigatória

## 📊 Monitoramento

O sistema inclui:

- Logs detalhados de todas as operações
- Estatísticas em tempo real
- Contadores de compras ativas
- Total de ganhos por dia
- Status de processamento

## 🐛 Troubleshooting

### Erro: "Saldo insuficiente"

- Verifique se o usuário tem saldo suficiente
- Confirme que o saldo no Firestore está correto

### Erro: "Compra sem data de início"

- Verifique se o campo `inicio` foi definido corretamente
- Use `serverTimestamp()` para datas consistentes

### Ganhos não aparecem

- Verifique se a compra está com `status: "ativo"`
- Confirme se o ciclo não expirou
- Execute o sistema de renda manualmente

## 📝 Notas Técnicas

- Usa Firebase Firestore v9 (compat)
- Transações garantem consistência de dados
- Interface responsiva para desktop e mobile
- Logs em tempo real para debugging
- Sistema modular e escalável

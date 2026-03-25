async function gerarRendaDiaria() {

  const hoje = new Date()

  const snapshot = await db.collection("compras")
    .where("status", "==", "ativo")
    .get()

  for (const doc of snapshot.docs) {

    const compra = doc.data()

    const inicio = compra.inicio.toDate()

    const diasPassados = Math.floor(
      (hoje - inicio) / (1000 * 60 * 60 * 24)
    )

    if (diasPassados < compra.ciclo) {

      const uid = compra.uid
      const renda = compra.rendaDiaria

      const userRef = db.collection("users").doc(uid)

      await db.runTransaction(async (t) => {

        const userDoc = await t.get(userRef)

        const saldoAtual = userDoc.data().saldo || 0

        const novoSaldo = saldoAtual + renda

        t.update(userRef, {
          saldo: novoSaldo
        })

      })

      await db.collection("ganhos").add({
        uid: uid,
        valor: renda,
        produto: compra.produto,
        data: new Date()
      })

    } else {

      await doc.ref.update({
        status: "finalizado"
      })

    }

  }

  console.log("Renda diária executada")

}
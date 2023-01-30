//
//  Message.swift
//  Mail
//
//  Created by Marco Dell'Isola on 18/11/22.
//

import Foundation

struct Message: Identifiable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}

final class MessageData: ObservableObject {
    @Published var mails: [Message] = [Message(id:"1", text: """
    Gentile Cliente, La informiamo che è stato autorizzato il pagamento a favore di:
    WWW.MYCICERO.IT
    WWW.MYCICERO.IT
    STRADA STATALE ADRIATICA
    60017 SENIGALLIA AN
    ITA
    Email Customer Care: ass@mycicero.it
    Telefono: 0719207000

    Data del pagamento: 16-11-2022
    Ora del pagamento: 07:43:06
    Importo: EUR 1,70
    Codice ordine pagamento: UCB_MOMO_36212480_0080

    Codice autorizzazione circuito: 184952
    Circuito di pagamento: Amex
    Nome e Cognome: Indirizzo E-mail: marcodellisola@outlook.it

    Distinti saluti.
    Nexi Payments SpA
    """, received: false, timestamp: Date()),
                         Message(id:"2", text:"""
    Thank you, you have the worst service ever! 🤗
    """, received: true, timestamp: Date()),
                         Message(id:"3", text: """
    Gentile Cliente, La informiamo che è stato autorizzato il pagamento a favore di:
    WWW.MYCICERO.IT
    WWW.MYCICERO.IT
    STRADA STATALE ADRIATICA
    60017 SENIGALLIA AN
    ITA
    Email Customer Care: ass@mycicero.it
    Telefono: 0719207000

    Data del pagamento: 16-11-2022
    Ora del pagamento: 07:43:06
    Importo: EUR 1,70
    Codice ordine pagamento: UCB_MOMO_36212480_0080

    Codice autorizzazione circuito: 184952
    Circuito di pagamento: Amex
    Nome e Cognome: Indirizzo E-mail: marcodellisola@outlook.it

    Distinti saluti.
    Nexi Payments SpA
    """, received: false, timestamp: Date()),
                                    Message(id: "4", text: "Always in time 👎", received: true, timestamp: Date())]
}

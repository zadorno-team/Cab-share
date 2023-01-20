//
//  UserModel.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 20/01/23.
//

import Foundation
import Firebase

class UserModel: ObservableObject {
    @Published var currentUser = Auth.auth().currentUser
    @Published var nameText = ""
    @Published var ageText = ""
    @Published var hometownText = ""
    @Published var emailText = ""
    @Published var passwordText = ""
    
    func upload() {
        let db = Firestore.firestore()
        db.collection("User").document(currentUser!.uid).setData(["nameText": $nameText, "ageText": $ageText, "hometownText": $hometownText, "emailText": $emailText, "passwordText": $passwordText])
    }
    func download() {
        let db = Firestore.firestore()
        db.collection("User").document(currentUser!.uid).getDocument {
            (snapshot, error) in
            if let error = error {
                // Handle error
            } else {
                guard let data = snapshot?.data() else { return }
                let emailText = data["emailText"] as? String
                let nameText = data["nameText"] as? String
                let passwordText = data["passwordText"] as? String
                let hometownText = data["hometownText"] as? String
                let ageText = data["ageText"] as? String
            }
        }
    }
}

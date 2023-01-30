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
        db.collection("UserInformation").document(currentUser!.uid).setData(["nameText": String(nameText), "ageText": String(ageText), "hometownText": String(hometownText), "emailText": String(emailText), "passwordText": String(passwordText)]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func download() {
        let db = Firestore.firestore()
        db.collection("UserInformation").document(currentUser!.uid).getDocument {
            (snapshot, error) in
            if let error = error {
                // Handle error
                print(error)
            } else {
                guard let data = snapshot?.data() else { return }
                self.emailText = data["emailText"] as? String ?? ""
                self.nameText = data["nameText"] as? String ?? ""
                self.passwordText = data["passwordText"] as? String ?? ""
                self.hometownText = data["hometownText"] as? String ?? ""
                self.ageText = data["ageText"] as? String ?? ""
            }
        }
    }
}

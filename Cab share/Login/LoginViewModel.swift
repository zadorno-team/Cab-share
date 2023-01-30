//
//  LoginViewModel.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 17/01/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = "test@gmail.com"
    @Published var password = "ciaociao"
    @Published var signInView = false
    @Published var userSignedUp = false
    @Published var userSignedIn = false
    func signUp(emailText: String, passwordText: String) {
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userSignedUp.toggle()
            }
        }
    }
    func signIn(emailText: String, passwordText: String) {
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userSignedIn.toggle()
            }
        }
    }
}

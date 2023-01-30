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
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userSignedUp.toggle()
            }
        }
    }
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userSignedIn.toggle()
            }
        }
    }
}

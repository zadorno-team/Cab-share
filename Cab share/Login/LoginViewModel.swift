//
//  LoginViewModel.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 17/01/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var emailSignedIn = ""
    @Published var passwordSignedIn = ""
    @Published var signInView = false
    @Published var userSignedUp = false
    @Published var userSignedIn = false
    func signUp() {
        Auth.auth().createUser(withEmail: emailSignedIn, password: passwordSignedIn) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userSignedUp.toggle()
            }
        }
    }
    func signIn() {
        Auth.auth().signIn(withEmail: emailSignedIn, password: passwordSignedIn) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else{
                self.userSignedIn.toggle()
            }
        }
    }
}

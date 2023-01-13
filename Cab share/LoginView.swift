//
//  LoginView.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 12/01/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var isShowingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white.opacity(0.15))
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    TextField("E-mail", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Login") {
                        autheticateUser(email: email, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.black)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in \(email)"), isActive: $isShowingLoginScreen) {
                        EmptyView()
                    }

                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func autheticateUser(email: String, password: String) {
        if email.lowercased() == "123" {
            wrongEmail = 0
            if password.lowercased() == "123" {
                wrongPassword = 0
                isShowingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongPassword = 2 
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

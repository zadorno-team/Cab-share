//
//  LoginView.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 12/01/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white.opacity(0.15))
                VStack {
                    if loginViewModel.signInView {
                        Text("Sign In")
                            .font(.system(size: 60))
                            .animation(.easeIn(duration: 3))
                    } else {
                        Text("Sign Up")
                            .font(.system(size: 60))
                            .animation(.easeIn(duration: 3))
                    }
                    Button {
                        loginViewModel.signInView.toggle()
                    } label: {
                        if loginViewModel.signInView {
                            Text("or sign up")
                                .font(.system(size: 23))
                                .underline()
                                .foregroundColor(.white)
                        } else {
                            Text("or sign in")
                                .font(.system(size: 23))
                                .underline()
                                .padding(.bottom, 10)
                                .foregroundColor(.white)
                        }
                    }
                    CustomTextField(placeholder: Text("E-mail").foregroundColor(.black), text: $loginViewModel.email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .foregroundColor(.black)
                    CustomSecureField(placeholder: Text("Password"), password: $loginViewModel.password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .foregroundColor(.black)
                    if loginViewModel.signInView {
                        Button("Sign In") {
                            loginViewModel.signIn()
                        }.foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(.black)
                            .cornerRadius(25)
                            .padding(.top, 30)
                    } else {
                        Button("Sign Up") {
                            loginViewModel.signUp()
                        }.foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(.black)
                            .cornerRadius(25)
                            .padding(.top, 30)
                    }
                    HStack {
                        Button {
                            //
                        } label: {
                            Image("apple")
                                .padding(.top, 50)
                        }
                        Button {
                            //
                        } label: {
                            Image("google")
                                .padding(.top, 50)
                                .padding(.leading, 20)
                        }
                        Button {
                            //
                        } label: {
                            Image("fb")
                                .padding(.top, 50)
                                .padding(.leading, 20)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()}
}

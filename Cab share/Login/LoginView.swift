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
    @EnvironmentObject var userModel: UserModel
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
                    Text("Sign In")
                        .font(.system(size: 60))
                        .animation(.spring())
                    Button {
                        loginViewModel.userSignedUp.toggle()
                    } label: {
                        Text("or sign up")
                                .font(.system(size: 23))
                                .underline()
                                .foregroundColor(.white)
                    }.sheet(isPresented: $loginViewModel.userSignedUp) {
                        UserSignUpView()
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
                    Button("Sign In") {
                        loginViewModel.signIn(emailText: loginViewModel.email, passwordText: loginViewModel.password)
                    }.foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(.black)
                        .cornerRadius(25)
                        .padding(.top, 30)
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
        LoginView().environmentObject(LoginViewModel())
    }
}

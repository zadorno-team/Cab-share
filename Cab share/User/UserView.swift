//
//  UserView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import Firebase

//struct UserView: View {
//    @State var isEditing = true
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    Text("Hello, Sasha! You're in Italy right now!")
//                        .font(.title2)
//                        .bold()
//                    Spacer()
//                    VStack {
//                        Image("sasha")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipShape(Circle())
//                    }
//                    .offset(x: 45, y: 0)
//                }
//                .padding()
//                VStack(alignment: .leading) {
//                    Text("Your name")
//                        .font(.headline)
//                    HStack {
//                        UserTextField(placeholder: Text("Print your name"), isDisabled: $isEditing, text: $loginViewModel.nameText)
//                    }
//                    .padding(.bottom, 2)
//                    .underline(isEditing == false)
//                    Text("Your age")
//                        .font(.headline)
//                    HStack {
//                        UserTextField(placeholder: Text("Print your age"), isDisabled: $isEditing, text: $loginViewModel.ageText)
//                    }
//                    .padding(.bottom, 2)
//                    .underline(isEditing == false)
//                    Text("Your hometown")
//                        .font(.headline)
//                    HStack {
//                        UserTextField(placeholder: Text("Print your hometown"), isDisabled: $isEditing, text: $loginViewModel.hometownText)
//                    }
//                    .padding(.bottom, 2)
//                    .underline(isEditing == false)
//                    Text("Your login")
//                        .font(.headline)
//                    HStack {
//                        UserTextField(placeholder: Text("Print your e-mail"), isDisabled: $isEditing, text: $loginViewModel.emailText)
//                    }
//                    .padding(.bottom, 2)
//                    .underline(isEditing == false)
//                    Text("Your password")
//                        .font(.headline)
//                    HStack {
//                        UserSecureField(placeholder: Text("Print your password"), isDisabled: $isEditing, text: $loginViewModel.passwordText)
//                    }
//                    .padding(.bottom, 2)
//                    .underline(isEditing == false)
//                }
//                .padding()
//                Spacer()
//            }
//            .onAppear{loginViewModel.download()}
//            .navigationTitle("User")
//            .preferredColorScheme(.dark)
//            .toolbar {
//                Button("Edit") {
//                    isEditing.toggle()
//                    if isEditing {
//                        loginViewModel.upload()
//                    }
//                }
//                .foregroundColor(.white)
//            }
//        }
//    }
//    struct UserView_Previews: PreviewProvider {
//        static var previews: some View {
//            UserView()
//                .environmentObject(LoginViewModel())
//        }
//    }
//}

//
//  UserInfoView.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 20/01/23.
//

import SwiftUI

struct UserSignUpView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showPicker = false
    let numbers = Array(1...80)
    var body: some View {
        VStack {
            CustomTextField(placeholder: Text("Name"), text: $userModel.nameText)
                .padding(.bottom, 20)
            CustomTextField(placeholder: Text("Age"), text: $userModel.ageText)
                .padding(.bottom, 20)
            CustomTextField(placeholder: Text("HomeTown"), text: $userModel.hometownText)
                .padding(.bottom, 20)
            CustomTextField(placeholder: Text("Email"), text: $userModel.emailText)
                .padding(.bottom, 20)
            CustomSecureField(placeholder: Text("Password"), password:
                                $userModel.passwordText)
                .padding(.bottom, 20)
            Button {
                loginViewModel.signUp(emailText: userModel.emailText, passwordText: userModel.passwordText)
                loginViewModel.signIn(emailText: userModel.emailText, passwordText: userModel.passwordText)
                userModel.upload()
                userModel.nameText = ""
                userModel.ageText = ""
                userModel.hometownText = ""
                userModel.emailText = ""
                userModel.passwordText = ""
                if loginViewModel.userSignedIn {
                    loginViewModel.userSignedIn.toggle()
                }
            } label: {
                Text("Sign Up")
                    .foregroundColor(.black)
            }.frame(width: 320, height: 60)
            .background(.white)
                .cornerRadius(25)
                .padding(.top, 100)
        }.padding(60)
        .preferredColorScheme(.dark)
    }
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView().environmentObject(UserModel())
    }
}

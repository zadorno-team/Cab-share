//
//  UserInfoView.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 20/01/23.
//

import SwiftUI

struct UserSignUpView: View {
    @EnvironmentObject var userModel: UserModel
    @State private var showPicker = false
    let numbers = Array(1...10)
    var body: some View {
        VStack{
            CustomTextField(placeholder: Text("Name"), text: $userModel.nameText)
            VStack {
                Button {
                    self.showPicker = true
                } label: {
                    if showPicker {
                        Picker("Select a number", selection: self.$userModel.ageText) {
                            ForEach(self.numbers, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    } else {
                        Text("How many people with you?").padding(.trailing, 25)
                    }
                }.frame(width: 260, height: 10)
                    .accentColor(.gray)
            }.padding()
            CustomTextField(placeholder: Text("HomeTown"), text: $userModel.hometownText)
            CustomTextField(placeholder: Text("Email"), text: $userModel.emailText)
            CustomSecureField(placeholder: Text("Password"), password:  $userModel.passwordText)
        }.preferredColorScheme(.dark)
    }
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView().environmentObject(UserModel())
    }
}

//
//  UserView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import Firebase

struct UserView: View {
    var nameType: String? = nil
    @State var isEditing = true
    @EnvironmentObject var userModel: UserModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hello, Sasha! You're in Italy right now!")
                        .font(.title2)
                        .bold()
                    Spacer()
                    VStack {
                        Image("sasha")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                    .offset(x: 45, y: 0)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Your name")
                        .font(.headline)
                    HStack {
                        UserTextField(placeholder: Text("Print your name"), isDisabled: $isEditing, text: $userModel.nameText)
                    }
                    .padding(.bottom, 2)
                    Text("Your age")
                        .font(.headline)
                    HStack {
                        UserTextField(placeholder: Text("Print your age"), isDisabled: $isEditing, text: $userModel.ageText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your hometown")
                        .font(.headline)
                    HStack {
                        UserTextField(placeholder: Text("Print your hometown"), isDisabled: $isEditing, text: $userModel.hometownText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your login")
                        .font(.headline)
                    HStack {
                        UserTextField(placeholder: Text("Print your e-mail"), isDisabled: $isEditing, text: $userModel.emailText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your password")
                        .font(.headline)
                    HStack {
                        UserSecureField(placeholder: Text("Print your password"), isDisabled: $isEditing, text: $userModel.passwordText)
                    }
                    .padding(.bottom, 2)
                }
                .padding()
                Spacer()
            }
            //            .onAppear{userModel.download()}
            .navigationTitle("User")
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Edit") {
                    isEditing.toggle()
                }
                .foregroundColor(.white)
            }
        }
    }
    
    
    struct UserView_Previews: PreviewProvider {
        static var previews: some View {
            UserView()
                .environmentObject(UserModel())
        }
    }
}

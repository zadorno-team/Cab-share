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
                        Button("edit") {
                            
                        }
                        .foregroundColor(.white)
                    }
                    .offset(x: 45, y: 0)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Your name")
                        .font(.headline)
                    HStack {
                        CustomTextField(placeholder: Text("Print your name"), text: $userModel.nameText)
                    }
                    .padding(.bottom, 2)
                    Text("Your age")
                        .font(.headline)
                    HStack {
                        CustomTextField(placeholder: Text("Print your age"), text: $userModel.ageText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your hometown")
                        .font(.headline)
                    HStack {
                        CustomTextField(placeholder: Text("Print your hometown"), text: $userModel.hometownText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your login")
                        .font(.headline)
                    HStack {
                        CustomTextField(placeholder: Text("Print your e-mail"), text: $userModel.emailText)
                    }
                    .padding(.bottom, 2)
                    
                    Text("Your password")
                        .font(.headline)
                    HStack {
                        SecureField("Print your password", text: $userModel.passwordText)
                    }
                    .padding(.bottom, 2)
                }
                .padding()
                Spacer()
                //                .padding()
                
            }
            .onAppear{userModel.download()}
            .navigationTitle("User")
            .preferredColorScheme(.dark)
            
        }
        
    }
//    func editButtonItem() -> UIBarButtonItem {
//           let editButton = editButtonItem()
//           editButton.action = "editButtonAction:"
//           return editButton
//      }
//
//      func editButtonAction(sender: UIBarButtonItem) {
//           if self.tableView.editing == true {
//                self.tableView.editing = false
//                sender.style = UIBarButtonItemStyle.Plain
//                sender.title = "Edit"
//           } else {
//                self.tableView.editing = true
//                sender.style = UIBarButtonItemStyle.Done
//                sender.title = "Done"
//           }
//      }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserModel())
    }
}

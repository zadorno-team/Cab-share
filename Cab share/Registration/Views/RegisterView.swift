//
//  RegisterView.swift
//  Firebase User Account Management
//
//  Created by Tunde on 22/05/2021.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl()
    )
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    InputTextFieldView(text: $viewModel.newUser.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       systemImage: "envelope")
                    InputPasswordView(password: $viewModel.newUser.password,
                                      placeholder: "Password",
                                      systemImage: "lock")
                    Divider()
                    InputTextFieldView(text: $viewModel.newUser.firstName,
                                       placeholder: "First Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $viewModel.newUser.lastName,
                                       placeholder: "Last Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $viewModel.newUser.age,
                                       placeholder: "Age",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $viewModel.newUser.homeTown,
                                       placeholder: "HomeTown",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                }
                ButtonView(title: "Sign up") {
                    viewModel.create()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register")
            .alert(isPresented: $viewModel.hasError,
                   content: {
                    if case .failed(let error) = viewModel.state {
                        return Alert(
                            title: Text("Error"),
                            message: Text(error.localizedDescription))
                    } else {
                        return Alert(
                            title: Text("Error"),
                            message: Text("Something went wrong"))
                    }
            })
            .applyClose()
            .preferredColorScheme(.dark)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
            RegisterView()
    }
}

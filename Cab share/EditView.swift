//
//  RegisterView.swift
//  Firebase User Account Management
//
//  Created by Tunde on 22/05/2021.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var service: SessionServiceImpl
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    InputTextFieldView(text: $service.userUpdates.firstName,
                                       placeholder: "First Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $service.userUpdates.lastName,
                                       placeholder: "Last Name",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $service.userUpdates.age,
                                       placeholder: "Age",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    InputTextFieldView(text: $service.userUpdates.homeTown,
                                       placeholder: "HomeTown",
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                }
                ButtonView(title: "Edit") {
                    service.edit()
                    dismiss()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Edit")
            .applyClose()
            .preferredColorScheme(.dark)
        }
    }
}

struct EditViewPreview: PreviewProvider {
    static var previews: some View {
            EditView()
            .environmentObject(SessionServiceImpl())
    }
}

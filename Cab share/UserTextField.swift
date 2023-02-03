//
//  UserTextField.swift
//  Cab share
//
//  Created by Aleksandra Nikiforova on 24/01/23.
//

import SwiftUI

struct UserTextField: View {
    let placeholder: Text
    @Binding var isDisabled: Bool
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text)
                .disabled(isDisabled)
        }
    }
}

struct UserSecureField: View {
    let placeholder: Text
    @Binding var isDisabled: Bool
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text)
                .disabled(isDisabled)
        }
    }
}

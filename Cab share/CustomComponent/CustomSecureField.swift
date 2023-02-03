//
//  CustomSecureField.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 16/01/23.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: Text
    @Binding var password: String
    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty { placeholder }
            SecureField("", text: $password)
        }
    }
}

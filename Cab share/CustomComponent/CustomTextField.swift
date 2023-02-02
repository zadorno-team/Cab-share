//
//  CustomSearchbar.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 13/01/23.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: Text
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text)
        }
    }
}

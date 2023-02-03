//
//  EditButtonViewModifier.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 01/02/23.
//

import SwiftUI

struct EditButtonViewModifier: ViewModifier {
    @EnvironmentObject var service: SessionServiceImpl
    @State var isEditing = false
    @State var editButton: String = "Edit"

    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(editButton) {
                    isEditing.toggle()
                }
                .foregroundColor(.white)
            }
            .sheet(isPresented: $isEditing){
                EditView()
            }
    }
}

extension View {

    func editButton() -> some View {
        self.modifier(EditButtonViewModifier())
    }
}

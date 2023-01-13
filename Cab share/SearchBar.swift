//
//  SearchBar.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 12/01/23.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    let data = ["apple", "banana", "cherry", "date", "elderberry"]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.black)
                CustomTextField(placeholder: Text("Where to?").foregroundColor(.black), text: $searchText)
                Button(action: {
                    self.searchText = ""
                }, label: {
                    if !searchText.isEmpty {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.black)
                    }})
            }.padding()

//            List {
//                ForEach(data.filter {
//                    self.searchText.isEmpty ? true : $0.localizedStandardContains(self.searchText)
//                }, id: \.self) {
//                    Text($0)
//                }
//            }
        }
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}

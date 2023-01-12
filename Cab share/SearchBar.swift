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
                TextField("Where to?", text: $searchText)
                    .foregroundColor(.black)
                Button(action: {
                    self.searchText = ""
                }, label: {
                    if !searchText.isEmpty {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
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

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}

//
//  UserView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Sasha Nicki")
                        .font(.title)
                        .bold()
                    Spacer()
                    VStack {
                        Image("sasha")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .padding(0)
                        Text("edit")
                    }
                }
                .padding()
                Spacer()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

            }
            .navigationTitle("User")
            
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

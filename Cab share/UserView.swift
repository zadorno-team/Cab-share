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
                    Text("Hello, Sasha! You're in Italy right now!")
                        .font(.title2)
                        .bold()
                    Spacer()
                    VStack {
                        Image("sasha")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        Text("edit")
                    }
                    .offset(x: 45, y: 0)
                    }
                .padding()

                VStack(alignment: .leading) {
                    Text("Your name")
                        .font(.headline)
                    HStack {
                        Text("Sasha Nicki")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("edit")
                    }
                    .padding(.bottom, 2)
                    Text("Your age")
                        .font(.headline)
                    HStack {
                        Text("26")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("edit")
                    }
                    .padding(.bottom, 2)

                    Text("Your hometown")
                        .font(.headline)
                    HStack {
                        Text("Portici")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("edit")
                    }
                    .padding(.bottom, 2)

                    Text("Your login")
                        .font(.headline)
                    HStack {
                        Text("sashenka@gmail.com")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("edit")
                    }
                    .padding(.bottom, 2)

                    Text("Your password")
                        .font(.headline)
                    HStack {
                        Text("HelloWorld2022")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("edit")
                    }
                    .padding(.bottom, 2)
                }
                .padding()
                Spacer()
//                .padding()

            }
            .navigationTitle("User")
            .preferredColorScheme(.dark)

        }

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

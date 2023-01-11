//
//  MainView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RideView()
                .tabItem {
                    Label("Ride", systemImage: "car.fill")
                }
            HistoryScreen()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            UserView()
                .tabItem {
                    Label("User", systemImage: "person.fill")
                }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

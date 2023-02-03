//
//  MainView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var rideVM = RideViewModel()
    var body: some View {
        TabView {
            RideView(rideVM: rideVM)
                .tabItem {
                    Label("Ride", systemImage: "car.fill")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            UserView()
                .tabItem {
                    Label("User", systemImage: "person.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

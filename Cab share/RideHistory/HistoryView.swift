//
//  HistoryView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @EnvironmentObject var service: SessionServiceImpl
    @Environment(\.managedObjectContext) var moc
    @State private var sheet = false

//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \service.lo.date, ascending: false)]
//    ) var rides: FetchedResults<Ride>

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(service.lobbyDetails) { lobby in
                    NavigationLink(destination: LobbyView(lobbyInformation: lobby), label: {HistoryRowView(lobby: lobby)})
                }
            }
            .navigationTitle("Previous Rides")
            .preferredColorScheme(.dark)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

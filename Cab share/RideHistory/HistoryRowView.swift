//
//  HistoryRowView.swift
//  Cab share
//
//  Created by Viacheslav on 12/01/23.
//

import SwiftUI

struct HistoryRowView: View {
    var lobby: LobbyDetails
    let calendar = Calendar.current

    enum Month {
        case january, february, march, april, may, june, july, august, september, october, november, dicember
    }

    var body: some View {
        let date = lobby.date.dateValue()
        let components = calendar.dateComponents([.day, .month, .year], from: date)

        let day = components.day!
        let month = components.month!
        let year = components.year!
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(day) \(month), \(year)")
                    .foregroundColor(.primary)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 3) {
                    Text("to: \(lobby.placemark)")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }.padding()
            Spacer()
            Image(systemName: "arrowtriangle.right")
                .padding()
        }.background(Color(hue: 1.0, saturation: 0.0, brightness: 0.252))
            .cornerRadius(23)
            .padding(15)

    }
}

//struct HistoryRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryRowView(ride: RideHistory(
//            date: "3 November, 2022",
//            goFrom: "International Airport of Naples",
//            goTo: "Portici"))
//    }
//}

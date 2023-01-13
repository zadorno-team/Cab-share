//
//  HistoryRowView.swift
//  Cab share
//
//  Created by Viacheslav on 12/01/23.
//

import SwiftUI

struct HistoryRowView: View {

    var ride: RideHistory

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(ride.date)
                    .foregroundColor(.primary)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 3) {
                    Text("from: \(ride.from)")
                    Text("to: \(ride.to)")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
            Spacer()
            Image(systemName: "arrowtriangle.right")
        }
    }
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRowView(ride: RideHistory(date: "3 November, 2022", from: "International Airport of Naples", to: "Portici"))
    }
}

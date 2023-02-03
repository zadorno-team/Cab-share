//
//  HistoryRowApiRequestView.swift
//  Cab share
//
//  Created by Viacheslav on 27/01/23.
//

import SwiftUI

struct HistoryRowApiRequestView: View {
    @Binding var historyRequests: [[String: String]]
    var body: some View {
        ForEach(historyRequests, id: \.self) {previousApiRequest in
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(previousApiRequest["departureAirport"] ?? "")
                        .foregroundColor(.primary)
                        .font(.headline)
                    Text(previousApiRequest["departureDate"] ?? "")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(previousApiRequest["departureTime"] ?? "")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 3) {
                    Text(previousApiRequest["arrivalAirport"] ?? "")
                        .foregroundColor(.primary)
                        .font(.headline)
                    Text(previousApiRequest["arrivalDate"] ?? "")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(previousApiRequest["arrivalTime"] ?? "")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "arrowtriangle.right")
            }
            .padding(.vertical)
            .padding(.horizontal, 50)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 1)
                    .padding(.horizontal, 25)
            )
        }
    }
}

struct HistoryRowApiRequestView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRowApiRequestView(historyRequests: .constant([[
            "departureAirport": "Sofia air",
            "departureDate": "12.05.2023"
        ]])).environmentObject(RideInformation())
    }
}

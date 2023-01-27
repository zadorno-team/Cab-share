//
//  HistoryRowApiRequestView.swift
//  Cab share
//
//  Created by Viacheslav on 27/01/23.
//

import SwiftUI

struct HistoryRowApiRequestView: View {
    @ObservedObject var rideVM: RideViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(rideVM.previousApiRequests?[0] ?? "")
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(rideVM.previousApiRequests?[1] ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Text(rideVM.previousApiRequests?[1] ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                Text(rideVM.previousApiRequests?[2] ?? "")
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(rideVM.previousApiRequests?[3] ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Text(rideVM.previousApiRequests?[4] ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "arrowtriangle.right")
        }
        .padding(.horizontal)
    }
}


struct HistoryRowApiRequestView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRowApiRequestView(rideVM: RideViewModel()).environmentObject(RideInformation())
    }
}

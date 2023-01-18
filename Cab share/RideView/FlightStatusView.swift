//
//  FlightStatusView.swift
//  Cab share
//
//  Created by Viacheslav on 18/01/23.
//

import SwiftUI

struct FlightStatusView: View {

    @ObservedObject var rideVM = RideViewModel()
    var body: some View {
        VStack {
            Text("")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct FlightStatusView_Previews: PreviewProvider {
    static var previews: some View {
        FlightStatusView()
    }
}

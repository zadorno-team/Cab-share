//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import SwiftUI

struct RideView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Text("Hello, Sasha! Nice to see you in the  International Airport of Naples!")
                        .foregroundColor(.white)
                    Spacer()
                }.background(Color.blue)
                    .cornerRadius(25)
            }
            .navigationTitle(Text("Ride")
                .foregroundColor(.white))
            .preferredColorScheme(.dark)
        }
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView()
    }
}

//
//  HomeView.swift
//  Firebase User Account Management
//
//  Created by Tunde on 22/05/2021.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var service: SessionServiceImpl
    var body: some View {
        VStack(alignment: .leading,
               spacing: 16) {
            VStack(alignment: .leading,
                   spacing: 16) {
                Text("First Name: \(service.userDetails?.firstName ?? "N/A")")
                Text("Last Name: \(service.userDetails?.lastName ?? "N/A")")
                Text("Age: \(service.userDetails?.age ?? "N/A")")
                Text("HomeTown: \(service.userDetails?.homeTown ?? "N/A")")
            }
            ButtonView(title: "Logout") {
                service.logout()
            }.padding(.top, 80)
        }.padding(.horizontal, 16)
               .navigationTitle("User")
               .preferredColorScheme(.dark)
               .editButton()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserView()
                .environmentObject(SessionServiceImpl())
        }
    }
}

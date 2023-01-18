//
//  RoutingView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 17/01/23.
//

import SwiftUI

struct RoutingView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        if loginViewModel.userSignedIn {
            MainView()
        } else if loginViewModel.userSignedUp {
            #warning("To complete with a guided navigation that allows to fill all the user's information")
        } else {
            LoginView()
        }
    }
}

struct RoutingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingView()
    }
}

//
//  RoutingView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 17/01/23.
//

import SwiftUI

struct RoutingView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userModel: UserModel
    var body: some View {
        if loginViewModel.userSignedIn {
            MainView()
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

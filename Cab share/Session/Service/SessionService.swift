//
//  SessionService.swift
//  Firebase User Account Management
//
//  Created by Tunde on 22/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

// Create a protocol with the following
/**
 * Init
 * state
 * Publisher to return the user so in the view model you can map and create a struct
 */

enum SessionState {
    case loggedIn
    case loggedOut
}


struct UserSessionUpdates {
    var firstName: String
    var lastName: String
    var age: String
    var homeTown: String
}

struct UserSessionDetails {
    var firstName: String
    var lastName: String
    var age: String
    var homeTown: String
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: UserSessionDetails? { get }
    init()
    func logout()
}

final class SessionServiceImpl: SessionService, ObservableObject {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserSessionDetails?
    @Published var userUpdates: UserSessionUpdates  = UserSessionUpdates(firstName: "",
                                                                         lastName: "",
                                                                         age: "",
                                                                         homeTown: "")
    private var handler: AuthStateDidChangeListenerHandle?
    private var subscriptions = Set<AnyCancellable>()
    init() {
        setupObservations()
    }
    deinit {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
        print("deinit SessionServiceImpl")
    }
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImpl {
    func setupObservations() {
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                let currentUser = Auth.auth().currentUser
                self.state = currentUser == nil ? .loggedOut : .loggedIn
                if let uid = currentUser?.uid {
                    Firestore.firestore().collection("Users").document(uid).getDocument { (snapshot, error) in
                                if let error = error {
                                    // Handle error
                                    print(error)
                                } else {
                                    guard let value = snapshot?.data(),
                                          let firstName = value[RegistrationKeys.firstName.rawValue] as? String,
                                          let lastName = value[RegistrationKeys.lastName.rawValue] as? String,
                                          let age = value[RegistrationKeys.age.rawValue] as? String,
                                          let homeTown = value[RegistrationKeys.homeTown.rawValue] as? String else { return }

                                    DispatchQueue.main.async {
                                        self.userDetails = UserSessionDetails(firstName: firstName,
                                                                              lastName: lastName,
                                                                              age: age,
                                                                              homeTown: homeTown)
                                    }
                                }
                            }
                }
            }
    }
}

extension SessionServiceImpl {
    func edit() {
        let currentUser = Auth.auth().currentUser
        if let uid = currentUser?.uid {
            let values = [RegistrationKeys.firstName.rawValue: userUpdates.firstName,
                          RegistrationKeys.lastName.rawValue: userUpdates.lastName,
                          RegistrationKeys.age.rawValue: userUpdates.age,
                          RegistrationKeys.homeTown.rawValue: userUpdates.homeTown] as [String : Any]
            Firestore
                .firestore()
                .collection("Users")
                .document(uid)
                .setData(values)
            setupObservations()
        }
    }
}


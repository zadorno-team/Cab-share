import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import MapKit
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

enum LobbyKeys: String {
    case date
    case latitude
    case longitude
    case placemark
    case users
    case hour
    case numUsers
    case namePlate
    case price
}

struct LobbyDetails: Identifiable {
    var id = UUID()
    //I had to make coordinate optional because of the architecture of MapView
    var date: Timestamp
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var placemark: String
    var users: [String]
    var hour: String
    var numUsers: String
    var namePlate: String
    var price: String
}

final class SessionServiceImpl: SessionService, ObservableObject {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserSessionDetails?
    @Published var userUpdates: UserSessionUpdates  = UserSessionUpdates(firstName: "",
                                                                         lastName: "",
                                                                         age: "",
                                                                         homeTown: "")
    @Published var lobbyDetails: [LobbyDetails] = []
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
                // HISTORYVIEW(RIDES) DOWNLOAD
                Firestore.firestore().collection("Rides").getDocuments { (snapshot, error) in
                    if let error = error {
                        // Handle error
                        print(error)
                        return
                    } else {
                        for value in snapshot!.documents {
                                let value = value.data()
                                  let users = value[LobbyKeys.users.rawValue] as? [String]
                                  let date = value[LobbyKeys.date.rawValue] as? Timestamp
                                  let latitude = value[LobbyKeys.latitude.rawValue] as? CLLocationDegrees
                                  let longitude = value[LobbyKeys.longitude.rawValue] as? CLLocationDegrees
                                  let placemark = value[LobbyKeys.placemark.rawValue] as? String
                                  let hour = value[LobbyKeys.hour.rawValue] as? String
                                  let numUsers = value[LobbyKeys.numUsers.rawValue] as? String
                                  let namePlate = value[LobbyKeys.namePlate.rawValue] as? String
                                  let price = value[LobbyKeys.price.rawValue] as? String
                            DispatchQueue.main.async {
                                // swiftlint:disable all
                                let lobby = LobbyDetails(date: date ?? Timestamp(date: Date()), latitude: latitude ?? CLLocationDegrees(), longitude: longitude ?? CLLocationDegrees(), placemark: placemark ?? "", users: users ?? [""], hour: hour ?? "", numUsers: numUsers ?? "", namePlate: namePlate ?? "", price: price ?? "")
                                self.lobbyDetails.append(lobby)
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
                          RegistrationKeys.homeTown.rawValue: userUpdates.homeTown] as [String: Any]
            Firestore
                .firestore()
                .collection("Users")
                .document(uid)
                .setData(values)
            setupObservations()
        }
    }
}


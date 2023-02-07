import Combine
import Foundation
import Firebase
import FirebaseFirestore

struct RegistrationCredentials: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var age: String
    var homeTown: String
}

protocol RegistrationService {
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error>
}

enum RegistrationKeys: String {
    case firstName
    case lastName
    case age
    case homeTown
}

final class RegistrationServiceImpl: RegistrationService {

    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> {

        //A publisher that awaits subscription before running the supplied closure to create a publisher for the new subscriber
        Deferred {
            //A publisher that eventually produces a single value and then finishes or fails.
            Future { promise in

                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        if let uid = res?.user.uid {
                            //We are defining a dictionary
                            let values = [RegistrationKeys.firstName.rawValue: credentials.firstName,
                                          RegistrationKeys.lastName.rawValue: credentials.lastName,
                                          RegistrationKeys.age.rawValue: credentials.age,
                                          RegistrationKeys.homeTown.rawValue: credentials.homeTown] as [String : Any]
                            Firestore.firestore().collection("Users").document(uid).setData(values) { error in
                                if let err = error {
                                    promise(.failure(err))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        }
                    }
                }
            }
        }
        //To return the result on the main thread
        .receive(on: RunLoop.main)
        // Use eraseToAnyPublisher() to expose an instance of AnyPublisher to the downstream subscriber, rather than this publisher’s actual type. This form of
        // type erasure preserves abstraction across API boundaries, such as different modules. When you expose your publishers as the AnyPublisher type, you
        // can change the underlying implementation over time without affecting existing clients.
        .eraseToAnyPublisher()
    }
}

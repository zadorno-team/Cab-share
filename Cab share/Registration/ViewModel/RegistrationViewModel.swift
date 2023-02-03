//
//  RegistrationViewModel.swift
//  Firebase User Account Management
//
//  Created by Tunde on 22/05/2021.
//

import Foundation
import Combine

enum  RegistrationState {
    case successfullyRegistered
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    func create()
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var hasError: Bool { get }
    var newUser: RegistrationCredentials { get }
    init(service: RegistrationService)
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    let service: RegistrationService
    @Published var state: RegistrationState = .na
    @Published var newUser = RegistrationCredentials(email: "",
                                                     password: "",
                                                     firstName: "",
                                                     lastName: "",
                                                     age: "",
                                                     homeTown: "")
    @Published var hasError: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscription()
    }
    func create() {
                
        service
            .register(with: newUser)
        //To see the result of the publisher
            .sink { [weak self] res in
            //In Swift, [weak self] prevents closures from causing memory leaks in your application. This is because when you use [weak self], you tell the compiler to create a weak reference to self.
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfullyRegistered
            }
            .store(in: &subscriptions)
    }
}

private extension RegistrationViewModelImpl {
    //.map just translate a value type recived into a new one that you choose
    func setupErrorSubscription() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfullyRegistered,
                     .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

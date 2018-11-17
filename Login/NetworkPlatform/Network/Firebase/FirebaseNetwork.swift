//
//  FirebaseNetwork.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Firebase

import Domain

public class FirebaseNetwork: NetworkProtocol {

    public init() {}
    
    public func initNetwork() {
        FirebaseApp.configure()
    }
    
    public func login(with credentials: Credentials) -> Completable {
        return Auth.auth().rx_signInWithCredentials(with: credentials)
    }
    
    public func register(with credentials: RegistrationCredentials) -> Completable {
        return Auth.auth().rx_createUserWithEmail(with: credentials)
    }
    
    public func saveUserInfos(name: String) -> Completable {
        return Auth.auth().rx_getCurrentUser()
            .map {
                Auth.auth().rx_editProfileName(user: $0, name: name)
            }
            .flatMapCompletable {
                $0
            }
    }
    
    public func signOut() -> Completable {
        return Auth.auth().rx_signOut()
    }
    
    public func isUserConnected() -> Single<Bool> {
        return Auth.auth().rx_isUserConnected()
    }
    
    public func addAuthStateObserver() -> Observable<UserInfos?> {
        return Auth.auth().rx_addStateDidChangeListener()
    }
    
}

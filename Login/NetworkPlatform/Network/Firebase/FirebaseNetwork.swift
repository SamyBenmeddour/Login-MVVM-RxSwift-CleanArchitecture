//
//  FirebaseNetwork.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseAuth
import FirebaseDatabase

import Domain

public class FirebaseNetwork: NetworkProtocol {

    public init() {}
    
    public func initNetwork() {
        FirebaseApp.configure()
    }
    
    public func login(with credentials: Credentials) -> Observable<Void> {
        return Auth.auth().rx_signInWithCredentials(with: credentials).map {_ in}
    }
    
    public func register(email: String, password: String) -> Observable<Void> {
        return Auth.auth().rx_createUserWithEmail(email: email, password: password)
    }
    
    public func signOut() -> Observable<Void> {
        return Auth.auth().rx_signOut().map {_ in}
    }
    
    public func isUserConnected() -> Single<Bool> {
        return Auth.auth().rx_isUserConnected()
    }
    
    public func addAuthStateListener() -> Observable<UserInfos?> {
        return Auth.auth().rx_addStateDidChangeListener()
    }
    
}

//
//  FirebaseNetwork.swift
//  Network
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
    
    public init() {
        
    }
    
    public func initNetwork() {
        FirebaseApp.configure()
    }
    
    public func login(email: String, password: String) -> Observable<UserInfos> {
        return Auth.auth().rx_signinWithEmail(email: email, password: password)
    }
    
    public func register(email: String, password: String) -> Observable<Bool> {
        return Auth.auth().rx_createUserWithEmail(email: email, password: password)
    }

}

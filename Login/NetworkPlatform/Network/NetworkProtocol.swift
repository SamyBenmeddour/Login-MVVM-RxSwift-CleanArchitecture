//
//  NetworkProtocol.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

public protocol NetworkProtocol {
    
    func initNetwork()
    
    func isUserConnected() -> Single<Bool>
    
    func addAuthStateObserver() -> Observable<UserInfos?>
    
    func login(with credentials: Credentials)  -> Completable
    
    func signOut() -> Completable
    
    func register(with credentials: RegistrationCredentials) -> Completable
    
    func saveUserInfos(name: String) -> Completable
    
}

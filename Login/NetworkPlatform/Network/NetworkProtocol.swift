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
    
    func addAuthStateListener() -> Observable<UserInfos?>
    
    func login(with credentials: Credentials)  -> Observable<Void>
    
    func signOut() -> Observable<Void>
    
    func register(email: String, password: String) -> Observable<Void>
}

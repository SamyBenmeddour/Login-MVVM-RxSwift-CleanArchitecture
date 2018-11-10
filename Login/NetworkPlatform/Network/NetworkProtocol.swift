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
    
    func isUserConnected() -> Observable<UserInfos?>
    
    func login(email: String, password: String)  -> Observable<Bool>
    
    func signOut() -> Observable<Bool>
    
    func register(email: String, password: String) -> Observable<Bool>
}

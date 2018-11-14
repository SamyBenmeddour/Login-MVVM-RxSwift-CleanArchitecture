//
//  LoginUseCase.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

final class LoginUseCase: Domain.LoginUseCase {
    
    var networkService: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.networkService = service
    }
    
    func login(with credentials: Credentials) -> Observable<Void> {
        return networkService.login(with: credentials)
    }
    
    func signOut() -> Observable<Void> {
        return networkService.signOut()
    }
    
    
}

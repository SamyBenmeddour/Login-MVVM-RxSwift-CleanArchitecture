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
    
    func login(email: String, password: String) -> Observable<Bool> {
        print("LoginUseCase.login")
        return networkService.login(email: email, password: password)
    }
    
    func signOut() -> Observable<Bool> {
        print("LoginUseCase.signOut")
        return networkService.signOut()
    }
    
    
}

//
//  LoginUseCase.swift
//  Network
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

final class LoginUseCase: Domain.LoginUseCase {
    
    var networkService: Network
    
    init(service: Network) {
        self.networkService = service
    }
    
    func login(email: String, password: String) -> Observable<UserInfos> {
        return networkService.login(email: email, password: password)
    }
    
    
}

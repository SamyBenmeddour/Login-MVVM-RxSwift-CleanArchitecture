//
//  RegisterUseCase.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

final class RegisterUseCase: Domain.RegisterUseCase {
    
    var networkService: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.networkService = service
    }
    
    func register(email: String, password: String) -> Observable<Bool> {
        return networkService.register(email: email, password: password)
    }
    
    
}

//
//  UseCasesProvider.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import Domain

public final class UseCasesProvider : Domain.UseCasesProvider {
    
    private let service: NetworkProtocol
    
    public init(with networkService: NetworkProtocol) {
        self.service = networkService
    }
    
    public func makeLoginUseCase() -> Domain.LoginUseCase {
        return LoginUseCase(service: self.service)
    }
    
    public func makeRegisterUseCase() -> Domain.RegisterUseCase {
        return RegisterUseCase(service: self.service)
    }
    
}

//
//  UseCaseProvider.swift
//  Network
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import Domain

final class UseCasesProvider : Domain.UseCasesProvider {
    
    private let service: Network
    
    public init(with networkService: Network) {
        self.service = networkService
    }
    
    func makeLoginUseCase() -> Domain.LoginUseCase {
        return LoginUseCase(service: self.service)
    }
    
    func makeRegisterUseCase() -> Domain.RegisterUseCase {
        return RegisterUseCase(service: self.service)
    }

}

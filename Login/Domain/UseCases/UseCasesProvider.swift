//
//  UseCasesProvider.swift
//  Domain
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

protocol UseCasesProvider {
    
    func makeLoginUseCase() -> LoginUseCase
    
    func makeNetworkUseCase() -> NetworkUseCase
    
    func makeRegisterUseCase() -> RegisterUseCase
    
}

//
//  LoginUseCase.swift
//  Domain
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

protocol LoginUseCase {
    
    func login(email: String, password: String) -> UserInfos
    
}

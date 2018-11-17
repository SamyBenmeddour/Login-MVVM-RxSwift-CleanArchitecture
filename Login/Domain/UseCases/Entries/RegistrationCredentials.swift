//
//  RegistrationCredentials.swift
//  Domain
//
//  Created by Samy on 15/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

public struct RegistrationCredentials {
    
    public let email: String
    public let name: String
    public let password: String
    public let confirmation: String
    
    public init(email: String, name: String, password: String, confirmation: String) {
        self.email = email
        self.name = name
        self.password = password
        self.confirmation = confirmation
    }
}

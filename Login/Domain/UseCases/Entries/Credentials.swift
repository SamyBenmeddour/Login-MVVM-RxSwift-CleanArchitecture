//
//  Credentials.swift
//  Domain
//
//  Created by Samy on 12/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

public struct Credentials {
    
    public let email: String
    public let password: String
    
    public init (email: String, password: String) {
        self.email = email
        self.password = password
    }
}

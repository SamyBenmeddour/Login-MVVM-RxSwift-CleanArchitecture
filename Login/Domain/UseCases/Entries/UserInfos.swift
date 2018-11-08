//
//  UserInfos.swift
//  Domain
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

public struct UserInfos {
    
    let UUID: String
    let email: String
    
    public init(UUID: String, email: String) {
        self.UUID = UUID
        self.email = email
    }
}

//
//  AuthenticationError.swift
//  Domain
//
//  Created by Samy on 17/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

public enum AuthenticationError : Error {
    
    case passwordConfirmationDoesNotMatch
}


extension AuthenticationError {
    
    public var localizedDescription: String {
        switch self {
            case .passwordConfirmationDoesNotMatch:
                return "The password confirmation does not match"
        }
    }
}

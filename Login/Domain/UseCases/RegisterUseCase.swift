//
//  RegisterUseCase.swift
//  Domain
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift

public protocol RegisterUseCase {
    func register(email: String, password: String) -> Observable<Void>
}

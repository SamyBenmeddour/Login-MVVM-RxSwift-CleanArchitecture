//
//  LogoutUseCase.swift
//  Domain
//
//  Created by Samy on 12/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift

public protocol LogoutUseCase {
    
    func logout() -> Observable<Void>
    
    func getUserInfos() -> Observable<UserInfos?>
    
}

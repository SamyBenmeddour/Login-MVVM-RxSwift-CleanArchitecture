//
//  LogoutUseCase.swift
//  NetworkPlatform
//
//  Created by Samy on 12/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

final class LogoutUseCase: Domain.LogoutUseCase {
    
    var networkService: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.networkService = service
    }
    
    func logout() -> Observable<Void> {
        return self.networkService.signOut()
    }
    
    func getUserInfos() -> Observable<UserInfos?> {
        return self.networkService.addAuthStateListener()
    }
}

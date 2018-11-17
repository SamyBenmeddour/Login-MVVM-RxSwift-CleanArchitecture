//
//  RegisterUseCase.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

final class RegisterUseCase: Domain.RegisterUseCase {
    
    var networkService: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.networkService = service
    }
    
    fileprivate func checkPassword(passwords: RegistrationCredentials) -> Completable {
        return Completable.create { completable in
            if passwords.password == passwords.confirmation {
                completable(.completed)
            } else {
                completable(.error(AuthenticationError.passwordConfirmationDoesNotMatch))
            }
            return Disposables.create()
        }
    }
    
    
    func register(with credentials: RegistrationCredentials) -> Observable<Void> {

        return self.checkPassword(passwords: credentials)
            .andThen(self.networkService.register(with: credentials))
            .andThen(self.networkService.saveUserInfos(name: credentials.name))
            .andThen(Observable.just(()))

        
    }
    
    
}

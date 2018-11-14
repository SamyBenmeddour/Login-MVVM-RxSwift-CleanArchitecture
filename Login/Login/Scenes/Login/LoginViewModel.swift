//
//  LoginViewModel.swift
//  Login
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import RxCocoa

import Domain

class LoginViewModel {
    
    private let useCase: LoginUseCase
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
}

extension LoginViewModel : ViewModelType {
    
    struct Input {
        let loginTrigger: Driver<Void>
        let email: Driver<String>
        let password: Driver<String>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let canLogin: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
                
        let emailAndPassword = Driver.combineLatest(input.email, input.password)
        
        let canLogin = Driver.combineLatest(emailAndPassword, activityIndicator.asDriver()) {
            return !$0.0.isEmpty && !$0.1.isEmpty && !$1
        }
        
        
        let login = input.loginTrigger
            .withLatestFrom(emailAndPassword)
            .map {
                return Credentials(email: $0.0, password: $0.1)
            }
            .flatMapLatest { credentials in
                return self.useCase.login(with: credentials)
                        .trackError(errorTracker)
                        .trackActivity(activityIndicator)
                        .asDriverOnErrorJustComplete()}

        let loading = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(
                    loading: loading,
                    error: errors,
                    canLogin: canLogin,
                    dismiss: login)
        }
}

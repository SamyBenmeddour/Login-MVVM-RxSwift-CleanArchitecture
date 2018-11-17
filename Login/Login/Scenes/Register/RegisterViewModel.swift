//
//  RegisterViewModel.swift
//  Login
//
//  Created by Samy on 15/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import RxCocoa

import Domain

class RegiserViewModel {
    
    private let services: RegisterUseCase
    
    init(services: RegisterUseCase) {
        self.services = services
    }
    
}

extension RegiserViewModel : ViewModelType {
    
    struct Input {
        let email: Driver<String>
        let name: Driver<String>
        let password: Driver<String>
        let confirmation: Driver<String>
        let registerTrigger: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let canRegister: Driver<Bool>
        let register: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let allFields = Driver.combineLatest(input.email,
                                             input.name,
                                             input.password,
                                             input.confirmation)
        
        let canRegister = Driver.combineLatest(allFields, activityIndicator.asDriver()) {
            return !$0.0.isEmpty
                && !$0.1.isEmpty
                && !$0.2.isEmpty
                && !$0.3.isEmpty && !$1
        }
        
        
        let register = input.registerTrigger
            .withLatestFrom(allFields)
            .map {
                return RegistrationCredentials(email: $0.0, name: $0.1, password: $0.2, confirmation: $0.3)
            }
            .flatMapLatest { credentials in
                return self.services
                    .register(with: credentials)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()
        
        return Output(loading: loading,
                      error: error,
                      canRegister: canRegister,
                      register: register)
    }
    
    
    
    
}

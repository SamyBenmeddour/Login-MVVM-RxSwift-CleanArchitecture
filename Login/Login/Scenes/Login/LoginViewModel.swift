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
        let logoutTrigger: Driver<Void>
        let email: Driver<String>
        let password: Driver<String>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let authState: Driver<UserInfos?>
        let canLogin: Driver<Bool>
        let canLogout: Driver<Bool>
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let authStatus = Application.shared.isUserLogged.asDriver(onErrorJustReturn: nil)
        
        let canLogin = Driver.combineLatest(input.email, input.password, authStatus) {
            return !$0.isEmpty && !$1.isEmpty && $2 == nil
        }
        
        let canLogout = authStatus.map {
            return $0 != nil
        }
        
        input.logoutTrigger.map {
            self.useCase
                .signOut()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
        }
    
    
        let loading = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(loading: loading,
                      error: errors,
                      authState: authStatus,
                      canLogin: canLogin,
                      canLogout: canLogout)
    }
}

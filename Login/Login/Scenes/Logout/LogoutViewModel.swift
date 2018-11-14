//
//  LogoutViewModel.swift
//  Login
//
//  Created by Samy on 12/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import RxCocoa

import Domain

class LogoutViewModel {
    
    private let service: LogoutUseCase
    
    init(service: LogoutUseCase) {
        self.service = service
    }
    
}

extension LogoutViewModel : ViewModelType {
    
    struct Input {
        let logoutTrigger: Driver<Void>
    }
    
    struct Output {
        let uid: Driver<String>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        
        let uid = service.getUserInfos().asDriver(onErrorJustReturn: nil)
            .map { $0 == nil ? "unreachable" : $0!.UUID }
            .map { "Your id is :\n\($0)" }
        
        let logout = input.logoutTrigger.flatMapLatest {
            return self.service.logout()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        return Output (
            uid: uid,
            error: errorTracker.asDriver(),
            loading: activityIndicator.asDriver(),
            dismiss: logout
        )
    }
    
}

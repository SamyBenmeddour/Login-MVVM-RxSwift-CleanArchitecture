//
//  Firebase+Rx.swift
//  Network
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import FirebaseAuth
import RxSwift
import Foundation
import Domain

extension Auth {
    
    func rx_signinWithEmail(email: String, password: String) -> Observable<UserInfos> {
        return Observable.create { (observer) -> Disposable in
            self.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(UserInfos(UUID: user!.user.uid, email: user!.user.email!))
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    func rx_createUserWithEmail(email: String, password: String) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            self.createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    if user != nil {
                        observer.onNext(true)
                        observer.onCompleted()
                        return
                    }
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
}

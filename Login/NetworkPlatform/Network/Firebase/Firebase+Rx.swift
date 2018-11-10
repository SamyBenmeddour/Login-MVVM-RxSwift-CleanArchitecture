//
//  Firebase+Rx.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import FirebaseAuth
import RxSwift
import Foundation
import Domain

extension Auth {
    
    func rx_signinWithEmail(email: String, password: String) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            self.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    guard user?.user != nil else {
                        observer.onCompleted()
                        return
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    func rx_signOut() -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            do {
                try self.signOut()
                observer.onNext(true)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
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

    func rx_addStateDidChangeListener() -> Observable<UserInfos?> {
        print("rx_addStateDidChangeListener")
        return Observable.create { (observer) -> Disposable in
            self.addStateDidChangeListener { (auth, user) in
                guard let _user = user else {
                    observer.onNext(nil)
                    return
                }
                observer.onNext(UserInfos(UUID: _user.uid, email: _user.email!))
            }
            return Disposables.create()
        }
    }
}

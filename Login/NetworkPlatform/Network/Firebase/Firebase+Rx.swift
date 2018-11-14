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
    
    func rx_signInWithCredentials(with credentials: Credentials) -> Observable<Bool> {
        return Observable.create { observer in
            self.signIn(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func rx_signOut() -> Observable<Bool> {
        return Observable.create { observer in
            do {
                try self.signOut()
                observer.onNext(true)
            } catch let error {
                observer.onError(error)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func rx_createUserWithEmail(email: String, password: String) -> Observable<Void> {
        return Observable.create { observer in
            self.createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    func rx_addStateDidChangeListener() -> Observable<UserInfos?> {
        return Observable.create { observer in
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
    
    func rx_isUserConnected() -> Single<Bool> {
        return Single<Bool>.create {single in
            single(.success(self.currentUser != nil))
            return Disposables.create()
        }
    }
}

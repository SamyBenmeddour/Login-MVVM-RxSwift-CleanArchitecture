//
//  Firebase+Rx.swift
//  NetworkPlatform
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import FirebaseAuth
import RxSwift

import Domain

internal extension Auth {
    
    internal func rx_signInWithCredentials(with credentials: Credentials) -> Completable {
        return Completable.create { completable in
            self.signIn(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            })
            return Disposables.create()
        }
    }
    
    internal func rx_signOut() -> Completable {
        return Completable.create { completable in
            do {
                try self.signOut()
                completable(.completed)
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
    
    internal func rx_getCurrentUser() -> Single<User> {
        return Single.create { single in
            if self.currentUser != nil {
                single(.success(self.currentUser!))
            } else {
                single(.error(AuthenticationError.passwordConfirmationDoesNotMatch))
            }
            return Disposables.create()
        }
    }
    
    internal func rx_createUserWithEmail(with credentials: RegistrationCredentials) -> Completable {
        return Completable.create { completable in
            self.createUser(withEmail: credentials.email, password: credentials.password, completion: { (user, error) in
                guard let error = error else {
                    completable(.completed)
                    return
                }
                completable(.error(error))
            })
            return Disposables.create()
        }
    }
    
    internal func rx_editProfileName(user: User, name: String) -> Completable {
        return Completable.create { completable in
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            
            changeRequest.commitChanges { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }

    internal func rx_addStateDidChangeListener() -> Observable<UserInfos?> {
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
    
    internal func rx_isUserConnected() -> Single<Bool> {
        return Single<Bool>.create {single in
            single(.success(self.currentUser != nil))
            return Disposables.create()
        }
    }
}

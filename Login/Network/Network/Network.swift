//
//  File.swift
//  Network
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import RxSwift
import Domain

protocol Network {
    
    func initNetwork()
    
    func login(email: String, password: String)  -> Observable<UserInfos>
    
    func register(email: String, password: String) -> Observable<Bool>
}

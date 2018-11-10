//
//  Application.swift
//  Login
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//
import RxSwift

import Domain
import NetworkPlatform

final class Application {
    
    static let shared = Application()
    private let disposeBag = DisposeBag()
    
    public let services: NetworkProtocol
    public let useCasesProvider: Domain.UseCasesProvider
    
    public lazy var isUserLogged : Observable<UserInfos?> = {
        return services.isUserConnected()
    }()
    
    private init() {
        self.services = FirebaseNetwork()
        self.useCasesProvider = NetworkPlatform.UseCasesProvider(with: self.services)
    }
    
    func configureNetwork() {
        services.initNetwork()
    }
    
    
}

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
    
    private init() {
        self.services = FirebaseNetwork()
        self.useCasesProvider = NetworkPlatform.UseCasesProvider(with: self.services)
    }
    
    func configureNetwork() {
        services.initNetwork()
    }
    
    fileprivate func toLoginScreen(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVc = storyboard.instantiateViewController(withIdentifier: "LoginScene") as! LoginViewController
        window.rootViewController = loginVc
    }
    
    fileprivate func toLogoutScreen(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logoutVc = storyboard.instantiateViewController(withIdentifier: "LogoutScene") as! LogoutViewController
        window.rootViewController = logoutVc
    }
    
    func configureMainInterface(in window: UIWindow) {
        self.services.isUserConnected().subscribe { event in
            switch event {
                case .success(let isConnected):
                    isConnected ? self.toLogoutScreen(in: window) : self.toLoginScreen(in: window)
                    break
                case .error(let error):
                    print("An error occured : \(error.localizedDescription)")
                    self.toLoginScreen(in: window)
                    break
            }
        }.disposed(by: DisposeBag())
    }
    
    
    
    
}

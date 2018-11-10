//
//  LoginViewController.swift
//  Login
//
//  Created by Samy on 08/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//


import RxSwift
import RxCocoa
import UIKit
import Domain

class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel!
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var logOutButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        self.viewModel = LoginViewModel(useCase: Application.shared
                                                            .useCasesProvider
                                                            .makeLoginUseCase())
        
        let input = LoginViewModel.Input(
            loginTrigger: loginButton.rx.tap.asDriver(),
            logoutTrigger: logOutButton.rx.tap.asDriver(),
            email: emailField.rx.text.orEmpty.asDriver(),
            password: passwordField.rx.text.orEmpty.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        
        var errorBinding: Binder<Error> {
            return Binder(self) {vc, error in
                let alert = UIAlertController(title: "Erreur",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Fermer",
                                           style: UIAlertAction.Style.cancel,
                                           handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true, completion: nil)
            }
        }
        
        
        var loadingBinding: Binder<Bool> {
            return Binder(self) { _, loading in
                print("loading: \(loading)")
            }
        }
        
        var authStatusBinding: Binder<UserInfos?> {
            print("Auth status has changed")
            return Binder(self) { _, user in
                guard let user = user else {
                    self.statusLabel.text = "Login"
                    return
                }
                self.statusLabel.text = "You are now logged, your id is : \n\(user.UUID)"
            }
        }
        
        output.error
            .drive(errorBinding)
            .disposed(by: self.disposeBag)
        
        output.loading
            .drive(loadingBinding)
            .disposed(by: self.disposeBag)
        
        output.canLogin
            .drive(self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        
         output.canLogout
            .drive(self.logOutButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        output.authState
            .drive(authStatusBinding)
            .disposed(by: self.disposeBag)
 
    }
}

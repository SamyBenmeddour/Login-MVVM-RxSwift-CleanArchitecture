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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        self.viewModel = LoginViewModel(useCase: Application.shared
                                                    .useCasesProvider
                                                    .makeLoginUseCase())
        
        let input = LoginViewModel.Input(loginTrigger: loginButton.rx.tap.asDriver(),
                                         email: emailField.rx.text.orEmpty.asDriver(),
                                         password: passwordField.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        
        var errorBinding: Binder<Error> {
            return Binder(self) { vc, error in
                
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Dismiss",
                                           style: UIAlertAction.Style.cancel,
                                           handler: nil)
                
                alert.addAction(action)
                vc.present(alert, animated: true, completion: nil)
            }
        }
        
        var loadingBinding: Binder<Bool> {
            return Binder(self) { _, loading in
                print("Loading: \(loading)")
            }
        }
        
        var dismissBinding: Binder<Void> {
            return Binder(self) { vc, _ in
                vc.performSegue(withIdentifier: "LoginToLogout", sender: vc)
            }
        }
        
        output.canLogin
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.error
            .drive(errorBinding)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(loadingBinding)
            .disposed(by: disposeBag)
        
        output.dismiss
            .drive(dismissBinding)
            .disposed(by: disposeBag)
    }
}

//
//  RegisterViewController.swift
//  Login
//
//  Created by Samy on 15/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class RegisterViewController : UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: RegiserViewModel!
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var confirmationField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        
        self.viewModel = RegiserViewModel(services: Application.shared.useCasesProvider.makeRegisterUseCase())
        
        
        let input = RegiserViewModel.Input(email: emailField.rx.text.orEmpty.asDriver(),
                                           name: nameField.rx.text.orEmpty.asDriver(),
                                           password: passwordField.rx.text.orEmpty.asDriver(),
                                           confirmation: confirmationField.rx.text.orEmpty.asDriver(),
                                           registerTrigger: registerButton.rx.tap.asDriver())
        
        
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
                print("Register scene : Loading: \(loading)")
            }
        }
        
        var dismissBinding: Binder<Void> {
            return Binder(self) { vc, _ in
                vc.performSegue(withIdentifier: "RegisterToLogout", sender: vc)
            }
        }
        
        
        output.canRegister
            .drive(self.registerButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        output.error
            .drive(errorBinding)
            .disposed(by: self.disposeBag)
        
        output.loading
            .drive(loadingBinding)
            .disposed(by: self.disposeBag)
        
        output.register
            .drive(dismissBinding)
            .disposed(by: self.disposeBag)
        
    }
}

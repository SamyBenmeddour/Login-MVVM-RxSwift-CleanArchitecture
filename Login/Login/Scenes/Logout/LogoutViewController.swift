//
//  LogoutViewController.swift
//  Login
//
//  Created by Samy on 12/11/2018.
//  Copyright © 2018 Benmeddour. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class LogoutViewController : UIViewController {
    
    private var viewModel: LogoutViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet var uidLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel = LogoutViewModel(service: Application.shared.useCasesProvider.makeLogoutUseCase())
        
        let input = LogoutViewModel.Input(logoutTrigger: logoutButton.rx.tap.asDriver())
        
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
                vc.performSegue(withIdentifier: "LogoutToLogin", sender: vc)
            }
        }
        
        output.loading
            .drive(loadingBinding)
            .disposed(by: self.disposeBag)
        
        output.error
            .drive(errorBinding)
            .disposed(by: self.disposeBag)
        
        output.dismiss
            .drive(dismissBinding)
            .disposed(by: self.disposeBag)
        
        output.uid
            .drive(self.uidLabel.rx.text)
            .disposed(by: self.disposeBag)
        
    }
}

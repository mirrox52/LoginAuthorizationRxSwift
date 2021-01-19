//
//  ViewController.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var email: String?
    private var password: String?
    let loginViewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        bindViewModels()
        checkLogIn()
    }
    
    private func bindViewModels() {
        emailTextField.rx
            .controlEvent(.editingDidEnd)
            .map { self.emailTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: loginViewModel.emailViewModel.email)
            .disposed(by: disposeBag)
        
        PasswordTextField.rx
            .controlEvent(.editingDidEnd)
            .map { self.emailTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: loginViewModel.passwordViewModel.password)
            .disposed(by: disposeBag)
        
        logInButton.rx.tap
//            .do { [weak self] in
//                self?.PasswordTextField.resignFirstResponder()
//                self?.emailTextField.resignFirstResponder()
//            }
            .subscribe(onNext: { [weak self] in
                guard let flag = self?.loginViewModel.validateLogin() else {
                    print("Bad email or password")
                    return
                }
                if flag {
                    self?.loginViewModel.loginUser()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkLogIn() {
        loginViewModel.isSuccess
            .subscribe(onNext: { log in
                if log {
                    print("User logged in")
                }
            })
            .disposed(by: disposeBag)
        
        loginViewModel.errorMessage
            .subscribe(onNext: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
}


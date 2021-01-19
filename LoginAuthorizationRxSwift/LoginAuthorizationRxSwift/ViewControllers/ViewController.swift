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
            .map { self.PasswordTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: loginViewModel.passwordViewModel.password)
            .disposed(by: disposeBag)
        
//        PasswordTextField.rx
//            .text.orEmpty
//            .filter{ !$0.isEmpty }
//            .bind(to: loginViewModel.emailViewModel.email)
//            .disposed(by: disposeBag)
        
        logInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let flag = self?.loginViewModel.validateLogin() else {
                    return
                }
                if flag {
                    self?.loginViewModel.loginUser()
                } else {
                    self?.showMessage(title: "Error", description: "Bad email or password")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkLogIn() {
        loginViewModel.isSuccess
            .skip(1)
            .subscribe(onNext: { [weak self] log in
                if log {
                    self?.showMessage(title: "Great", description: "user logged in")
                } else {
                    self?.showMessage(title: "Error", description: "no such user")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showMessage(title: String, description: String?) {
      alert(title: title, text: description)
        .subscribe()
        .disposed(by: disposeBag)
    }
    
}


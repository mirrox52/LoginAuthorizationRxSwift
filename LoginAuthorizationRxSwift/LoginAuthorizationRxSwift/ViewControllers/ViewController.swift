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
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        bindViewModels()
        checkLogIn()
        toSignUp()
    }
    
}

private extension ViewController {
    private func bindViewModels() {
        emailTextField.rx
            .text.orEmpty
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")
            .drive(loginViewModel.emailViewModel.email)
            .disposed(by: disposeBag)
        
        PasswordTextField.rx
            .text.orEmpty
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")
            .drive(loginViewModel.passwordViewModel.password)
            .disposed(by: disposeBag)
        
        logInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.driveInput()
                self?.loginViewModel.logIn()
            })
            .disposed(by: disposeBag)
    }
    
    private func checkLogIn() {
        loginViewModel.isSuccess
            .skip(1)
            .subscribe(onNext: { [weak self] message in
                self?.showMessage(title: "Log In", description: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func toSignUp() {
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let signUpViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                self?.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func showMessage(title: String, description: String?) {
      alert(title: title, text: description)
        .subscribe()
        .disposed(by: disposeBag)
    }
}


//
//  SignUpViewController.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordToConfirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let signUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        
        bindViewModels()
    }
    
    private func bindViewModels() {
        emailTextField.rx
            .controlEvent(.editingDidEnd)
            .map { self.emailTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.emailViewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .controlEvent(.editingDidEnd)
            .map { self.passwordTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.passwordViewModel.password)
            .disposed(by: disposeBag)
        
        passwordToConfirmTextField.rx
            .controlEvent(.editingDidEnd)
            .map { self.passwordToConfirmTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.passwordToRepeatViewModel.password)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let flag = self?.signUpViewModel.validateSignUp() else {
                    return
                }
                if flag {
                    self?.signUpViewModel.signUpUser()
                } else {
                    self?.showMessage(title: "Error", description: "Bad email or password")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkSignUp() {
        signUpViewModel.isSuccess
            .subscribe(onNext: { [weak self] sign in
                if sign {
                    self?.showMessage(title: "Great", description: "User logged in")
                } else {
                    self?.showMessage(title: "Error", description: "user can't sign up")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showMessage(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }

}

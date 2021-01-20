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
        
        style()
        bindViewModels()
        checkSignUp()
    }

}

extension SignUpViewController {
    private func style() {
        title = "Sign Up"
    }
    
    private func bindViewModels() {
        emailTextField.rx
            .text.orEmpty
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.emailViewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .text.orEmpty
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.passwordViewModel.password)
            .disposed(by: disposeBag)
        
        passwordToConfirmTextField.rx
            .text.orEmpty
            .filter { !$0.isEmpty }
            .bind(to: signUpViewModel.passwordToRepeatViewModel.password)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.signUpViewModel.driveInput()
                self?.signUpViewModel.signUp()
            })
            .disposed(by: disposeBag)
    }
    
    private func checkSignUp() {
        signUpViewModel.isSuccess
            .skip(1)
            .subscribe(onNext: { [weak self] message in
                self?.showMessage(title: "Sign Up", description: message)
            })
            .disposed(by: disposeBag)
    }
    
    func showMessage(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }
}

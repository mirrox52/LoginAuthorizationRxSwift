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
        
        
    }
    
    func showMessage(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }

}

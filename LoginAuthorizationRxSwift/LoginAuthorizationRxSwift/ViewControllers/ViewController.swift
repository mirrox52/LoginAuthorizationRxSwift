//
//  ViewController.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var email: String?
    private var password: String?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpTapped()
    }
    
    private func logInTapped() {
        logInButton.rx.tap
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
    
    private func signUpTapped() {
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let signUpViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
                self?.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

//    private func takeEmailAndPassword() {
//
//        let emailInput = emailTextField.rx
//            .controlEvent(.editingDidEnd)
//            .map { self.emailTextField.text ?? "" }
//            .filter{ !$0.isEmpty }
//            .subscribe(onNext: { text in
//                print(text)
//            }, onError: { error in
//                print(error.localizedDescription)
//            }, onCompleted: {
//                print("Completed")
//            }, onDisposed: {
//                print("Disposed")
//            })
//            .disposed(by: disposeBag)
//
//        let passwordInput = PasswordTextField.rx
//            .controlEvent(.editingDidEnd)
//            .map { self.PasswordTextField.text ?? "" }
//            .filter { !$0.isEmpty }
//            .subscribe(onNext: { text in
//                print(text)
//            }, onError: { error in
//                print(error.localizedDescription)
//            }, onCompleted: {
//                print("Completed")
//            }, onDisposed: {
//                print("Disposed")
//            })
//            .disposed(by: disposeBag)
//    }
    
}


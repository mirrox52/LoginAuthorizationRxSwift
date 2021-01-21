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
        bind()
//        checkLogIn()
//        toSignUp()
    }
    
}

//private extension ViewController {
//    private func bind() {
//        emailTextField.rx
//            .text.orEmpty
//            .filter { !$0.isEmpty }
//            .asDriver(onErrorJustReturn: "")
//            .drive(loginViewModel.emailViewModel.email)
//            .disposed(by: disposeBag)
//
//        PasswordTextField.rx
//            .text.orEmpty
//            .filter { !$0.isEmpty }
//            .asDriver(onErrorJustReturn: "")
//            .drive(loginViewModel.passwordViewModel.password)
//            .disposed(by: disposeBag)
//
//        logInButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.loginViewModel.driveInput()
//                self?.loginViewModel.logIn()
//            })
//            .disposed(by: disposeBag)
//    }
//
//    private func checkLogIn() {
//        loginViewModel.isSuccess
//            .skip(1)
//            .subscribe(onNext: { [weak self] message in
//                self?.alert(title: "Log In", text: message)
//                    .subscribe()
//                    .disposed(by: self!.disposeBag)
//            })
//            .disposed(by: disposeBag)
//    }
//
//    private func toSignUp() {
//        signUpButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                let signUpViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//                self?.navigationController?.pushViewController(signUpViewController, animated: true)
//            })
//            .disposed(by: disposeBag)
//    }
//
//}

private extension ViewController {
    
    var input: LoginViewModel.Input {
        .init(
            login: emailTextField.rx.text.orEmpty.asDriver(),
            password: PasswordTextField.rx.text.orEmpty.asDriver()
        )
    }
    
    func bind() {
        logInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print(self.input)
                let output = self.transform(input: self.input, to: self.loginViewModel, disposingTo: self.disposeBag)
                output.inputErrors.subscribe(onSuccess: { [weak self] _ in
                    guard let self = self else { return }
                    output.loggedIn.subscribe(onSuccess: { [weak self] message in
                        guard let self = self else { return }
                        self.alert(title: "Sign up", text: message)
                            .subscribe()
                            .disposed(by: self.disposeBag)
                    }, onError: { [weak self] error in
                        guard let self = self else { return }
                        self.alert(title: "Sign up", text: error.localizedDescription)
                            .subscribe()
                            .disposed(by: self.disposeBag)
                    })
                    .disposed(by: self.disposeBag)
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.alert(title: "Sign up", text: error.localizedDescription)
                        .subscribe()
                        .disposed(by: self.disposeBag)
                })
                .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}

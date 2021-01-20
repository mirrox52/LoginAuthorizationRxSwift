//
//  LoginViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa

//class LoginViewModel {
//    let loginModel: LoginModel = LoginModel()
//    let disposeBag = DisposeBag()
//
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//
//    let isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
//
//    func validateLogin() -> Bool {
//        return emailViewModel.checkEmail() && passwordViewModel.checkPassword()
//    }
//
//    func loginUser() {
//        loginModel.email = emailViewModel.email.value
//        loginModel.password = passwordViewModel.password.value
//
//        ApiController.shared.logIn(email: loginModel.email, password: loginModel.password)
//            .subscribe(onSuccess: { [weak self] message in
//                self?.isSuccess.accept(true)
//            }, onError: { [weak self] error in
//                self?.isSuccess.accept(false)
//            })
//            .disposed(by: disposeBag)
//    }
//}

class LoginViewModel {
    let isSuccess: BehaviorRelay<String> = BehaviorRelay(value: "")
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    
    private let loginUseCase = LoginUseCase()
    
    private let disposeBag = DisposeBag()
    
    func driveInput() {
        emailViewModel.email.asDriver()
            .drive(loginUseCase.emailViewModel.email)
            .disposed(by: disposeBag)
        
        passwordViewModel.password.asDriver()
            .drive(loginUseCase.passwordViewModel.password)
            .disposed(by: disposeBag)
    }
    
    func logIn() {
        loginUseCase.validateLoginInput()
            .subscribe(onSuccess: { [weak self] _ in
                self?.loginUseCase.loginUser()
                    .subscribe(onSuccess: { [weak self] message in
                        self?.isSuccess.accept("User logged in")
                    }, onError: { error in
                        self?.isSuccess.accept(error.localizedDescription)
                    })
                    .disposed(by: self!.disposeBag)
            }, onError: { error in
                self.isSuccess.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
}

//
//  LoginViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class LoginViewModel {
    let loginModel: LoginModel = LoginModel()
    let disposeBag = DisposeBag()
    
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    
    let isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMessage: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func validateLogin() -> Bool {
        return emailViewModel.checkEmail() && passwordViewModel.checkPassword()
    }
    
    func loginUser() {
        loginModel.email = emailViewModel.email.value
        loginModel.password = passwordViewModel.password.value
        
        ApiController.shared.logIn(email: loginModel.email, password: loginModel.password)
            .subscribe(onSuccess: { [weak self] _ in
                self?.isSuccess.accept(true)
            }, onError: { [weak self] error in
                self?.isSuccess.accept(false)
                self?.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

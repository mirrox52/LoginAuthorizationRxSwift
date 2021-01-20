//
//  LoginUseCase.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 20.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginUseCase {
    
    let loginModel = LoginModel()
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    
    let disposeBag = DisposeBag()
    
    func validateLoginInput() -> Single<Bool> {
        return Single<Bool>.create { [weak self] single in
            let flag = (self?.emailViewModel.checkEmail() ?? false) && (self?.passwordViewModel.checkPassword() ?? false)
            if flag {
                single(.success(true))
            } else {
                single(.error(ValidationError.invalidInput))
            }
            return Disposables.create()
        }
    }
    
    func loginUser() -> Single<Bool> {
        loginModel.email = emailViewModel.email.value
        loginModel.password = passwordViewModel.password.value
        return Single<Bool>.create { [weak self] single in
            ApiController.shared.logIn(email: self?.loginModel.email, password: self?.loginModel.password)
                .subscribe(onSuccess: { _ in
                    single(.success(true))
                }, onError: { error in
                    single(.error(ValidationError.noSuchUser))
                })
                .disposed(by: self?.disposeBag)
            return Disposables.create()
        }
    }
    
}

//
//  SignUpUseCase.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 20.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpUseCase {
    
    let signUpModel: SignUpModel = SignUpModel()
    let disposeBag = DisposeBag()
    
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    let passwordToRepeatViewModel = PasswordViewModel()
    
    func validateSignUpInput() -> Single<Bool> {
        return Single<Bool>.create { [weak self] single in
            let flag = (self?.emailViewModel.checkEmail() ?? false) && (self?.passwordViewModel.checkPassword() ?? false) && (self?.passwordToRepeatViewModel.checkPassword() ?? false)
            if flag {
                single(.success(true))
            } else {
                single(.error(ValidationError.invalidInput))
            }
            return Disposables.create()
        }
    }
    
    func signUpUser() -> Single<Bool> {
        signUpModel.email = emailViewModel.email.value
        signUpModel.password = passwordViewModel.password.value
        signUpModel.passwordToRepeat = passwordToRepeatViewModel.password.value
        return Single<Bool>.create { [weak self] single in
            ApiController.shared.signUp(email: self?.signUpModel.email, password: self?.signUpModel.password, passwordToConfirm: self?.signUpModel.passwordToRepeat)
                .subscribe(onSuccess: { single in
                    single(.success(true))
                }, onError: { [weak self] _ in
                    single(.error(ValidationError.thisEmailAlreadyExists))
                })
                .disposed(by: self?.disposeBag)
            return Disposables.create()
        }
    }
    
}

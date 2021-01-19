//
//  SigUpViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 19.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    let signUpModel: SignUpModel = SignUpModel()
    let disposeBag = DisposeBag()
    
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    let passwordToRepeatViewModel = PasswordViewModel()
    
    let isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func validateSignUp() -> Bool {
        return emailViewModel.checkEmail() && passwordViewModel.checkPassword() && passwordToRepeatViewModel.checkPassword()
    }
    
    func signUpUser() {
        signUpModel.email = emailViewModel.email.value
        signUpModel.password = passwordViewModel.password.value
        signUpModel.passwordToRepeat = passwordToRepeatViewModel.password.value
        
        ApiController.shared.signUp(email: signUpModel.email, password: signUpModel.password, passwordToConfirm: signUpModel.passwordToRepeat)
            .subscribe(onSuccess: { [weak self] message in
                self?.isSuccess.accept(true)
            }, onError: { [weak self] error in
                self?.isSuccess.accept(false)
            })
            .disposed(by: disposeBag)
    }
}

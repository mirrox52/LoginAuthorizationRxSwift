//
//  SigUpViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 19.01.21.
//

import Foundation
import RxSwift
import RxCocoa

//class SignUpViewModel {
//    let signUpModel: SignUpModel = SignUpModel()
//    let disposeBag = DisposeBag()
//
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//    let passwordToRepeatViewModel = PasswordViewModel()
//
//    let isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
//
//    func validateSignUp() -> Bool {
//        print(emailViewModel.email.value)
//        print(passwordViewModel.password.value)
//        print(passwordToRepeatViewModel.password.value)
//        return emailViewModel.checkEmail() && passwordViewModel.checkPassword() && passwordToRepeatViewModel.checkPassword()
//    }
//
//    func signUpUser() {
//        signUpModel.email = emailViewModel.email.value
//        signUpModel.password = passwordViewModel.password.value
//        signUpModel.passwordToRepeat = passwordToRepeatViewModel.password.value
//
//        ApiController.shared.signUp(email: signUpModel.email, password: signUpModel.password, passwordToConfirm: signUpModel.passwordToRepeat)
//            .subscribe(onSuccess: { [weak self] _ in
//                self?.isSuccess.accept(true)
//            }, onError: { [weak self] _ in
//                self?.isSuccess.accept(false)
//            })
//            .disposed(by: disposeBag)
//    }
//}

class SignUpViewModel {
    let isSuccess: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    let passwordToRepeatViewModel = PasswordViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let signUpUseCase = SignUpUseCase()
    
    func driveInput() {
        emailViewModel.email.asDriver()
            .drive(signUpUseCase.emailViewModel.email)
            .disposed(by: disposeBag)
        
        passwordViewModel.password.asDriver()
            .drive(signUpUseCase.passwordViewModel.password)
            .disposed(by: disposeBag)
        
        passwordToRepeatViewModel.password.asDriver()
            .drive(signUpUseCase.passwordToRepeatViewModel.password)
            .disposed(by: disposeBag)
    }
    
    func signUp() {
        signUpUseCase.validateSignUpInput()
            .subscribe(onSuccess: { [weak self] _ in
                self?.signUpUseCase.signUpUser()
                    .subscribe(onSuccess: { [weak self] message in
                        self?.isSuccess.accept("User signed up")
                    }, onError: { error in
                        self?.isSuccess.accept(error.localizedDescription)
                    })
                    .disposed(by: self!.disposeBag)
            }, onError: { [weak self] error in
                self?.isSuccess.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

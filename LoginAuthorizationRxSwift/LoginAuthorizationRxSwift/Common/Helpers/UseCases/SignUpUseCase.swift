//
//  SignUpUseCase.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 20.01.21.
//

import Foundation
import RxSwift
import RxCocoa

//class SignUpUseCase {
//
//    let signUpModel: SignUpModel = SignUpModel()
//    let disposeBag = DisposeBag()
//
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//    let passwordToRepeatViewModel = PasswordViewModel()
//
//    func validateSignUpInput() -> Single<Bool> {
//        return Single<Bool>.create { [weak self] single in
//            let flag = (self?.emailViewModel.checkEmail() ?? false) && (self?.passwordViewModel.checkPassword() ?? false) && (self?.passwordToRepeatViewModel.checkPassword() ?? false)
//            if flag {
//                single(.success(true))
//            } else {
//                single(.error(ValidationError.invalidInput))
//            }
//            return Disposables.create()
//        }
//    }
//
//    func signUpUser() -> Single<String> {
//        signUpModel.email = emailViewModel.email.value
//        signUpModel.password = passwordViewModel.password.value
//        signUpModel.passwordToRepeat = passwordToRepeatViewModel.password.value
//        return ApiController.shared.signUp(email: signUpModel.email, password: signUpModel.password, passwordToConfirm: signUpModel.passwordToRepeat)
//
//    }
//}

class SignUpUseCase {
    
    struct Input {
        var login: Driver<String>
        var password: Driver<String>
        var passwordToConfirm: Driver<String>
    }
    
    func validateInput(input: Input) -> Single<String> {
        var email = ""
        var password = ""
        var passwordToConfirm = ""
        let _ = Driver.combineLatest(input.login, input.password, input.passwordToConfirm)
            .map {
                email = $0
                password = $1
                passwordToConfirm = $2
            }
        print(email)
        print(password)
        print(passwordToConfirm)
        return Validation.shared.checkInputSignUp(email: email, password: password, passwordToRepeat: passwordToConfirm)
    }
    
    func produce(input: Input) -> Single<String> {
        var email = ""
        var password = ""
        let _ = Driver.combineLatest(input.login, input.password)
            .map {
                email = $0
                password = $1
            }
        return ApiController.shared.signUp(email: email, password: password)
//            .asDriver(onErrorJustReturn: "Log in error")
    }
}
    

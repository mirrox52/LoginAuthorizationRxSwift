//
//  LoginUseCase.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 20.01.21.
//

import Foundation
import RxSwift
import RxCocoa

//class LoginUseCase {
//
//    let loginModel = LoginModel()
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//
//    let disposeBag = DisposeBag()
//
//    func validateLoginInput() -> Single<Bool> {
//        return Single<Bool>.create { [weak self] single in
//            let flag = (self?.emailViewModel.checkEmail() ?? false) && (self?.passwordViewModel.checkPassword() ?? false)
//            if flag {
//                single(.success(true))
//            } else {
//                single(.error(ValidationError.invalidInput))
//            }
//            return Disposables.create()
//        }
//    }
//
//    func loginUser() -> Single<String> {
//        loginModel.email = emailViewModel.email.value
//        loginModel.password = passwordViewModel.password.value
//        return ApiController.shared.logIn(email: loginModel.email, password: loginModel.password)
//    }
//}

class LoginUseCase {
    
    struct Input {
        var login: Driver<String>
        var password: Driver<String>
    }
    
    func validateInput(input: Input) -> Single<String> {
        var email = ""
        var password = ""
        let _ = Driver.combineLatest(input.login, input.password)
            .map {
                email = $0
                password = $1
            }
        print(email)
        print(password)
        return Validation.shared.checkInputSignIn(email: email, password: password)
    }
    
    func produce(input: Input) -> Single<String> {
        var email = ""
        var password = ""
        let _ = Driver.combineLatest(input.login, input.password)
            .map {
                email = $0
                password = $1
            }
        return ApiController.shared.logIn(email: email, password: password)
//            .asDriver(onErrorJustReturn: "Log in error")
    }
}




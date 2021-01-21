//
//  LoginViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa
import Action

//class LoginViewModel {
//
//    let isSuccess: BehaviorRelay<String> = BehaviorRelay(value: "")
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//
//    private let loginUseCase = LoginUseCase()
//
//    private let disposeBag = DisposeBag()
//
//    func driveInput() {
//        emailViewModel.email.asDriver()
//            .drive(loginUseCase.emailViewModel.email)
//            .disposed(by: disposeBag)
//
//        passwordViewModel.password.asDriver()
//            .drive(loginUseCase.passwordViewModel.password)
//            .disposed(by: disposeBag)
//    }
//
//    func logIn() {
//        loginUseCase.validateLoginInput()
//            .subscribe(onSuccess: { [weak self] _ in
//                self?.loginUseCase.loginUser()
//                    .subscribe(onSuccess: { [weak self] message in
//                        self?.isSuccess.accept("User logged in")
//                    }, onError: { error in
//                        self?.isSuccess.accept(error.localizedDescription)
//                    })
//                    .disposed(by: self!.disposeBag)
//            }, onError: { error in
//                self.isSuccess.accept(error.localizedDescription)
//            })
//            .disposed(by: disposeBag)
//    }
//
//}

class LoginViewModel {
    private let loginUseCase: LoginUseCase
    init() {
        loginUseCase = LoginUseCase()
    }
}

extension LoginViewModel: ViewModelType {
    
    struct Input {
        var login: Driver<String>
        var password: Driver<String>
    }
    
    struct Output {
        let inputErrors: Single<String>
        let loggedIn: Single<String>
    }
    
    func transform(input: Input) -> Output {
//        print(input.login)
//        print(input.password)
        let isInputValid = loginUseCase.validateInput(input: input.toLoginUseCaseInput())
        let login = loginUseCase.produce(input: input.toLoginUseCaseInput())
        return Output(inputErrors: isInputValid, loggedIn: login)
    }
}

private extension LoginViewModel.Input {
    
    func toLoginUseCaseInput() -> LoginUseCase.Input {
        return .init(login: login, password: password)
    }
}

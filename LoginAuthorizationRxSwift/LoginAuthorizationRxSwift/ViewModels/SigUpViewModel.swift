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
//    let isSuccess: BehaviorRelay<String> = BehaviorRelay(value: "")
//
//    let emailViewModel = EmailViewModel()
//    let passwordViewModel = PasswordViewModel()
//    let passwordToRepeatViewModel = PasswordViewModel()
//
//    private let disposeBag = DisposeBag()
//
//    private let signUpUseCase = SignUpUseCase()
//
//    func driveInput() {
//        emailViewModel.email.asDriver()
//            .drive(signUpUseCase.emailViewModel.email)
//            .disposed(by: disposeBag)
//
//        passwordViewModel.password.asDriver()
//            .drive(signUpUseCase.passwordViewModel.password)
//            .disposed(by: disposeBag)
//
//        passwordToRepeatViewModel.password.asDriver()
//            .drive(signUpUseCase.passwordToRepeatViewModel.password)
//            .disposed(by: disposeBag)
//    }
//
//    func signUp() {
//        signUpUseCase.validateSignUpInput()
//            .subscribe(onSuccess: { [weak self] _ in
//                self?.signUpUseCase.signUpUser()
//                    .subscribe(onSuccess: { [weak self] message in
//                        self?.isSuccess.accept("User signed up")
//                    }, onError: { error in
//                        self?.isSuccess.accept(error.localizedDescription)
//                    })
//                    .disposed(by: self!.disposeBag)
//            }, onError: { [weak self] error in
//                self?.isSuccess.accept(error.localizedDescription)
//            })
//            .disposed(by: disposeBag)
//    }
//}

class SignUpViewModel {
    private let signUpUseCase: SignUpUseCase
    init() {
        signUpUseCase = SignUpUseCase()
    }
}

extension SignUpViewModel: ViewModelType {
    
    struct Input {
        var login: Driver<String>
        var password: Driver<String>
        var passwordToConfirm: Driver<String>
    }
    
    struct Output {
        let inputErrors: Single<String>
        let signedUp: Single<String>
    }
    
    func transform(input: Input) -> Output {
        let isInputValid = signUpUseCase.validateInput(input: input.toSignUpUseCaseInput())
        let signUp = signUpUseCase.produce(input: input.toSignUpUseCaseInput())
        return Output(inputErrors: isInputValid, signedUp: signUp)
    }
}

private extension SignUpViewModel.Input {
    
    func toSignUpUseCaseInput() -> SignUpUseCase.Input {
        return .init(login: login, password: password, passwordToConfirm: passwordToConfirm)
    }
}


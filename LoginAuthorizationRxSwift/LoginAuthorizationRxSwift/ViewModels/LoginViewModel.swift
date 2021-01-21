//
//  LoginViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa

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

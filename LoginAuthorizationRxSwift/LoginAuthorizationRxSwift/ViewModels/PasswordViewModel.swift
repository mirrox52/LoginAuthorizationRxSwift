//
//  PasswordViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class PasswordViewModel {
    var errorMessage: String = "Please enter a valid password"
    
    var password: BehaviorRelay<String> = BehaviorRelay(value: "")
    var passwordError: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func checkPassword() -> Bool {
        if password.value.count >= 6 {
            passwordError.accept(errorMessage)
            return true
        } else {
            passwordError.accept("")
            return false
        }
    }
}

//
//  EmailViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class EmailViewModel {
    var errorMessage: String = "Please enter a valid email"
    
    var email: BehaviorRelay<String> = BehaviorRelay(value: "")
    var emailError: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func checkEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email.value)
    }
}

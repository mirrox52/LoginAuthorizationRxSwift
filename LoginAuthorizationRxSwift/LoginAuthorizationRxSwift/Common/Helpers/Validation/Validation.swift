//
//  Validation.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 21.01.21.
//

import Foundation
import RxSwift
import RxCocoa

class Validation {
    
    static let shared = Validation()
    
    private func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return true
        } else {
            return false
        }
    }
    
    private func checkPassword(password: String) -> Bool {
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    func checkInputSignIn(email: String, password: String) -> Single<String> {
        return Single<String>.create { [weak self] single in
            if ((self?.checkEmail(email: email) ?? false) && (self?.checkPassword(password: password) ?? false)) == false {
                single(.error(ValidationError.invalidInput))
                return Disposables.create()
            }
            single(.success("Input correct"))
            return Disposables.create()
        }
    }
    
    func checkInputSignUp(email: String, password: String, passwordToRepeat: String) -> Single<String> {
        return Single<String>.create { [weak self] single in
            if ((self?.checkEmail(email: email) ?? false) && (self?.checkPassword(password: password) ?? false) && (self?.checkPassword(password: passwordToRepeat)) ?? false) == false {
                single(.error(ValidationError.invalidInput))
                return Disposables.create()
            }
            if password == passwordToRepeat {
                single(.success("Input correct"))
                return Disposables.create()
            }
            single(.error(ValidationError.passwordsAreNotEqual))
            return Disposables.create()
        }
    }
    
}

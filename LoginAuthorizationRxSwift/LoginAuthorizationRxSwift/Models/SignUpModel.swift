//
//  SignUpModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 19.01.21.
//

import Foundation

class SignUpModel {
    var email: String = ""
    var password: String = ""
    var passwordToRepeat: String = ""
    
    convenience init(email: String, password: String, passwordToRepeat: String) {
        self.init()
        self.email = email
        self.password = password
        self.passwordToRepeat = passwordToRepeat
    }
}

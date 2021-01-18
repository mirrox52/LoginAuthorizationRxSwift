//
//  LoginModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation

class LoginModel {
    var email: String = ""
    var password: String = ""
    
    init() {}
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

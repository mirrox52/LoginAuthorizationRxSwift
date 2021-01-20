//
//  User.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}

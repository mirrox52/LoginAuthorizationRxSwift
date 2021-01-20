//
//  ValidationErrors.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 19.01.21.
//

import Foundation

enum ValidationError: Error {
    case noSuchUser
    case thisEmailAlreadyExists
    case dbIsEmpty
    case passwordsAreNotEqual
    case invalidInput
}

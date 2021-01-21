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

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dbIsEmpty:
            return NSLocalizedString("Data Base is empty", comment: "")
        case .noSuchUser:
            return NSLocalizedString("User not found", comment: "")
        case .thisEmailAlreadyExists:
            return NSLocalizedString("This email already exists", comment: "")
        case .passwordsAreNotEqual:
            return NSLocalizedString("Passwords are not equal", comment: "")
        case .invalidInput:
            return NSLocalizedString("Check your input please", comment: "")
        }
    }
}

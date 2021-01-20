//
//  ApiController.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class ApiController {
    
    private let realm = try? Realm()
    
    static var shared = ApiController()
    
    func logIn(email: String, password: String) -> Single<String> {
        return Single<String>.create { [weak self] single in
            guard let users = self?.realm?.objects(User.self) else {
                single(.error(ValidationError.dbIsEmpty))
                return Disposables.create()
            }
            for user in users {
                if user.email == email, user.password == password {
                    single(.success("User logged in"))
                    return Disposables.create()
                }
            }
            single(.error(ValidationError.noSuchUser))
            return Disposables.create()
        }
    }
    
    func signUp(email: String, password: String, passwordToConfirm: String) -> Single<String> {
        return Single<String>.create{ [weak self] single in
            if password != passwordToConfirm {
                single(.error(ValidationError.passwordsAreNotEqual))
                return Disposables.create()
            }
            guard let users = self?.realm?.objects(User.self) else {
                single(.success("User signed up"))
                let user = User(email: email, password: password)
                try! self?.realm?.write {
                    self?.realm?.add(user)
                }
                return Disposables.create()
            }
            for user in users {
                if user.email == email {
                    single(.error(ValidationError.thisEmailAlreadyExists))
                    return Disposables.create()
                }
            }
            let user = User(email: email, password: password)
            try? self?.realm?.write {
                self?.realm?.add(user)
            }
            single(.success("User signed up"))
            return Disposables.create()
        }
    }
}

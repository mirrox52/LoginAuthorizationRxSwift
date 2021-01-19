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
    private let realm = try! Realm()
    
    var errorMessageForLogIn: String = "No such user"
    var errorMessageForSignUp: String = "This Email already exists"
    
//    let realmSignIn: BehaviorRelay<String> = BehaviorRelay(value: "")
//    let errorRealmSignIn: BehaviorRelay<String> = BehaviorRelay(value: "")
    
//    let realmSignUp: BehaviorRelay<String> = BehaviorRelay(value: "")
//    let errorRealmSignUp: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    static var shared = ApiController()
    
    func logIn(email: String, password: String) -> Single<Bool> {
        return Single<Bool>.create { [weak self] single in
            guard let users = self?.realm.objects(User.self) else {
//                self?.realmSignIn.accept("User logged in")
//                self?.errorRealmSignIn.accept("")
                single(.success(true))
                return Disposables.create()
            }
            for user in users {
                if user.email == email, user.password == password {
//                    self?.realmSignIn.accept("User logged in")
//                    self?.errorRealmSignIn.accept("")
                    single(.success(true))
                    return Disposables.create()
                }
            }
//            self?.errorRealmSignIn.accept(self!.errorMessageForLogIn)
            single(.error(false as! Error))
            return Disposables.create()
        }
    }
    
    func signUp(email: String, password: String) -> Single<Bool> {
        return Single<Bool>.create{ [weak self] single in
            guard let users = self?.realm.objects(User.self) else {
//                self?.realmSignUp.accept("User signed up")
//                self?.errorRealmSignUp.accept("")
                single(.success(true))
                return Disposables.create()
            }
            for user in users {
                if user.email == email {
//                    self?.errorRealmSignUp.accept("User with this Email already exists")
                    single(.error(false as! Error))
                    return Disposables.create()
                }
            }
            let user = User(email: email, password: password)
            try! self?.realm.write {
                self?.realm.add(user)
            }
//            self?.errorRealmSignIn.accept("")
//            self?.realmSignUp.accept("User signed up")
            single(.success(true))
            return Disposables.create()
        }
    }
}

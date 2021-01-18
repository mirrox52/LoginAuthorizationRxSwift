//
//  RealmViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class RealmLogInViewModel {
    private let realm = try! Realm()
    private var users: Results<User>!
    
    var errorMessage: String = "No such user"
    let realmChecking: BehaviorRelay<String> = BehaviorRelay(value: "")
    let errorRealm: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func checkUserFromRealm(email: String, password: String) {
        users = realm.objects(User.self)
        for user in users {
            if user.email == email, user.password == password {
                errorRealm.accept("")
                realmChecking.accept("User logged in")
                return
            }
        }
        errorRealm.accept(errorMessage)
    }
}

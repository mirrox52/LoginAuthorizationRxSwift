//
//  SignUpViewController.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordToConfirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let realm = try! Realm()
    private var items: Results<User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
    }
    
    private func bindViewModels() {
        
    }
    
//    private func signUpTapped() {
//        signUpButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                guard let email = self?.emailTextField.text,
//                      let password = self?.passwordTextField.text,
//                      let passwordToConfirm = self?.passwordToConfirmTextField.text
//                else { return }
//                if password == passwordToConfirm {
//                    let user = User(value: [email, password])
//                    self?.items = self?.realm.objects(User.self)
//                    for item in self!.items {
//                        if item.email == email {
//                            self?.showMessage(title: "Warning", description: "There is user with this email")
//                            return
//                        }
//                    }
//                    try! self?.realm.write {
//                        self?.realm.add(user)
//                    }
//                    self?.showMessage(title: "Great", description: "New user has been added")
//                    self?.navigationController?.popViewController(animated: true)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
    
    func showMessage(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }

}

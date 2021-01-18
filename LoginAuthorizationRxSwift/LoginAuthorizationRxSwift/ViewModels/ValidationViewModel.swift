//
//  ValidationViewModel.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 18.01.21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ValidationViewModel {
    var errorMessage: String { get }
    
    var data: BehaviorRelay <Bool>(value: true) { get set }
}

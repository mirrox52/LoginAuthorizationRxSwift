//
//  ViewModelType.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 20.01.21.
//

import Foundation
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

//
//  UIViewController+ViewModelBinding.swift
//  LoginAuthorizationRxSwift
//
//  Created by Aliaksandr on 21.01.21.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
    
    func transform<ViewModel: ViewModelType>(input: ViewModel.Input, to viewModel: ViewModel, disposingTo bag: DisposeBag) -> ViewModel.Output {
        let output = viewModel.transform(input: input)
        return output
    }
}

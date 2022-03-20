//
//  AddAccount.swift
//  Domain
//
//  Created by William on 20/03/22.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel: AddAccountModel,onComplete: @escaping (Result<AccountModel, Error>) -> Void )
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}

//
//  RemoteAddAccount.swift
//  Data
//
//  Created by William on 21/03/22.
//

import Foundation
import Domain

public final class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient?
    
    public init(to url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(requestModel: AddAccountModel, onComplete: @escaping (DomainError) -> Void){
        let data = requestModel.toData()
        httpClient?.post(to: url, with: data){ error in
            onComplete(.unexpected)
        }
    }
}

public enum DomainError {
    case unexpected
}

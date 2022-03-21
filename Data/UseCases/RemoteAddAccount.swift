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
    
    init(to url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(requestModel: AddAccountModel){
        let data = requestModel.toData()
        httpClient?.post(to: url, with: data)
    }
}

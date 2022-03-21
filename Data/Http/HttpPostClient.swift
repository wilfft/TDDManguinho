//
//  HttpPostClient.swift
//  Data
//
//  Created by William on 21/03/22.
//

import Foundation
public protocol HttpPostClient {
    func post(to url: URL,with data: Data?)
}

//
//  Model.swift
//  Domain
//
//  Created by William on 21/03/22.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

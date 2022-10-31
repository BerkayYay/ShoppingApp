//
//  Encodable+Extensions.swift
//  Shopping App
//
//  Created by Berkay YAY on 31.10.2022.
//

import Foundation
extension Encodable {
    var dictionary: [String: Any]? {
        get throws {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data,
                                                              options: .allowFragments) as? [String: Any]
            return dictionary
        }
    }
}

//
//  Encodable+Extension.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 08/06/21.
//

import Foundation

extension Encodable {
	
	subscript(key: String) -> Any? {
		return dictionary[key]
	}
	
	var dictionary: [String: Any] {
		return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
	}
	
}

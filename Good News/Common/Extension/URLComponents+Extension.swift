//
//  URLComponents+Extension.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 08/06/21.
//

import Foundation

extension URLComponents {
	
	mutating func setQueryItems(with parameters: [String: Any]) {
		self.queryItems = parameters
			.mapValues { String(describing: $0) }
			.map { URLQueryItem(name: $0.key, value: $0.value) }
	}
	
}

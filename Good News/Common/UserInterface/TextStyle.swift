//
//  TextStyle.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import UIKit

class TextStyle {
	
	private var attributes = [NSAttributedString.Key : Any]()
	
	init(size: CGFloat, weight: UIFont.Weight, color: UIColor = .white) {
		attributes[.font] = UIFont.systemFont(ofSize: size, weight: weight)
		attributes[.foregroundColor] = color
	}
	
	func getText(from text: String) -> NSAttributedString {
		return NSAttributedString(string: text, attributes: attributes)
	}
	
}

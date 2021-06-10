//
//  HomeHeaderViewModel.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation

class HomeHeaderViewModel {
	
	func getFormattedDate(from date: Date = Date()) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE d MMMM"
		
		return dateFormatter.string(from: date).uppercased()
	}
}

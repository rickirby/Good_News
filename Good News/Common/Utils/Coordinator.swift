//
//  Coordinator.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import UIKit

protocol Coordinator {
	
	var rootViewController: UIViewController { get }
	
	func start()
}

//
//  AppCoordinator.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import UIKit

class AppCoordinator: Coordinator {
	
	// MARK: - Public Properties
	
	var rootViewController: UIViewController {
		return UIViewController()
	}
	
	// MARK: - Private Properties
	
	private var homeCoordinator: HomeCoordinator?
	
	// MARK: - Public Methods
	
	func start() {
		homeCoordinator = nil
		homeCoordinator = HomeCoordinator()
		
		guard let homeCoordinator = homeCoordinator else {
			return
		}
		
		homeCoordinator.start()
		Navigator.shared.window?.overrideUserInterfaceStyle = .dark
		Navigator.shared.setRootViewController(homeCoordinator.rootViewController)
	}

}

//
//  Navigator.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import UIKit

final class Navigator {
	
	static let shared = Navigator()
	var window: UIWindow?
	
	func setRootViewController(_ viewController: UIViewController) {
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}
	
	func push(_ viewController: UIViewController, on coordinator: Coordinator, animated isAnimated: Bool = true) {
		guard let navigationController = coordinator.rootViewController as? UINavigationController else {
			return
		}
		
		if navigationController.viewControllers.count == 0 {
			navigationController.setViewControllers([viewController], animated: true)
			return
		}
		
		navigationController.pushViewController(viewController, animated: isAnimated)
	}
	
	func present(_ viewController: UIViewController, on target: UIViewController, animated isAnimated: Bool = true) {
		target.present(viewController, animated: isAnimated, completion: nil)
	}
	
	func popViewController(on coordinator: Coordinator, animated isAnimated: Bool = true) {
		guard let navigationController = coordinator.rootViewController as? UINavigationController else {
			return
		}
		
		navigationController.popViewController(animated: isAnimated)
	}
	
	func popToRootViewController(on coordinator: Coordinator, animated isAnimated: Bool = true) {
		guard let navigationController = coordinator.rootViewController as? UINavigationController else {
			return
		}
		
		navigationController.popToRootViewController(animated: isAnimated)
	}
}

//
//  HomeCoordinator.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import UIKit

class HomeCoordinator: Coordinator {
	
	// MARK: - Public Properties
	
	var rootViewController: UIViewController {
		return navigationController
	}
	
	// MARK: - Private Properties
	
	private let navigationController: UINavigationController
	private var newsListCoordinator: NewsListCoordinator?
	
	
	// MARK: - Initializer
	
	init() {
		navigationController = UINavigationController()
	}
	
	// MARK: - Public Methods
	
	func start() {
		let viewController = makeViewController()
		
		Navigator.shared.push(viewController, on: self)
	}
	
	// MARK: - Private Methods
	
	private func makeViewController() -> UIViewController {
		let viewModel = HomeViewModel()
		let viewController = HomeViewController(viewModel: viewModel)
		viewController.onExecuteNavigation = { [weak self] navigationType in
			switch navigationType {
			case .newsList(let preloadedArticles, let totalResult):
				self?.openNewsList(preloadedArticles, totalResult: totalResult)
			}
		}
		
		return viewController
	}
	
	private func openNewsList(_ preloadedArticles: [NewsArticleResObject], totalResult: Int) {
		newsListCoordinator = nil
		newsListCoordinator = NewsListCoordinator(navigationController: rootViewController as? UINavigationController ?? UINavigationController())
		newsListCoordinator?.preloadedArticles = preloadedArticles
		newsListCoordinator?.totalResult = totalResult
		
		newsListCoordinator?.start()
	}
	
}

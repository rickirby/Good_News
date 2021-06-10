//
//  NewsListCoordinator.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import UIKit

class NewsListCoordinator: Coordinator {
	
	// MARK: - Public Properties
	
	var preloadedArticles: [NewsArticleResObject] = []
	var totalResult: Int = 0
	var rootViewController: UIViewController {
		return navigationController
	}
	
	// MARK: - Private Properties
	
	private let navigationController: UINavigationController
	
	// MARK: - Initalizer
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: - Public Methods
	
	func start() {
		let viewController = makeViewController()
		
		Navigator.shared.push(viewController, on: self)
	}
	
	// MARK: - Private Methods
	
	private func makeViewController() -> UIViewController {
		let viewModel = NewsListViewModel()
		viewModel.articles = preloadedArticles
		viewModel.totalResult = totalResult
		viewModel.lastArticlesCount = preloadedArticles.count
		let viewController = NewsListViewController(viewModel: viewModel)
		viewController.onExecuteNavigation = { [weak self] navigationType in
			switch navigationType {
			case .web(let url):
				self?.openWeb(url: url)
			}
		}
		
		return viewController
	}
	
	private func openWeb(url: String) {
		let viewController = WebViewController(url: url)
		
		Navigator.shared.push(viewController, on: self)
	}
}

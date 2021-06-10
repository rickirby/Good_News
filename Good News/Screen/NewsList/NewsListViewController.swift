//
//  NewsListViewController.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit

class NewsListViewController: ASDKViewController<ASDisplayNode> {
	
	enum NavigationType {
		case web(url: String)
	}
	
	var onExecuteNavigation: ((NavigationType) -> Void)?
	
	let viewModel: NewsListViewModel
	let mainNode: NewsListNode
	
	init(viewModel: NewsListViewModel) {
		self.viewModel = viewModel
		self.mainNode = NewsListNode(viewModel: viewModel)
		
		super.init(node: mainNode)
		title = "News List"
		
		configureMainNode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func configureMainNode() {
		mainNode.onTapNews = { [weak self] url in
			self?.onExecuteNavigation?(.web(url: url))
		}
	}
}

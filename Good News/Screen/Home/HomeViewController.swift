//
//  HomeViewController.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

class HomeViewController: ASDKViewController<ASDisplayNode> {
	
	enum NavigationType {
		case newsList(preloadedArticles: [NewsArticleResObject], totalResult: Int)
	}
	
	var onExecuteNavigation: ((NavigationType) -> Void)?
	
	let viewModel: HomeViewModel
	let mainNode: HomeNode

	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		self.mainNode = HomeNode(viewModel: viewModel)
		
		super.init(node: mainNode)
		
		configureMainNode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		
		configureBlurEffectViewStatusBar()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.weatherViewModel.loadData()
		viewModel.newsViewModel.loadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	private func configureMainNode() {
		mainNode.onTapNews = { [weak self] in
			
			guard let self = self else {
				return
			}
			
			self.onExecuteNavigation?(.newsList(preloadedArticles: self.viewModel.newsViewModel.articles, totalResult: self.viewModel.newsViewModel.totalResult))
		}
	}
	
	private func configureBlurEffectViewStatusBar() {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(blurEffectView)
		
		blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		blurEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
	}
	
}

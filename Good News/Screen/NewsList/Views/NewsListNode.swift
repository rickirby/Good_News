//
//  NewsListNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit

class NewsListNode: ASDisplayNode {
	
	var onTapNews: ((String) -> Void)?
	
	private lazy var tableNode: ASTableNode = ASTableNode(style: .plain)
	
	private var currentPage: Int = 1
	private var isLoading: Bool = false
	
	private let viewModel: NewsListViewModel
	
	init(viewModel: NewsListViewModel) {
		self.viewModel = viewModel
		
		super.init()
		automaticallyManagesSubnodes = true
		
		configureViewModel()
		configureTableNode()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		return ASWrapperLayoutSpec(layoutElement: tableNode)
	}
	
	private func configureViewModel() {
		viewModel.onNeedRefresh = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				
				guard let self = self else {
					return
				}
				
				self.isLoading = false
				self.tableNode.performBatchUpdates({
					var indexPaths: [IndexPath] = []
					for index in self.viewModel.lastArticlesCount ..< self.viewModel.articles.count {
						indexPaths.append(IndexPath(row: index, section: 0))
					}
					
					self.tableNode.deleteRows(at: [IndexPath(row: self.viewModel.lastArticlesCount, section: 0)], with: .fade)
					self.tableNode.insertRows(at: indexPaths, with: .bottom)
					
					self.viewModel.lastArticlesCount = self.viewModel.articles.count
				}, completion: nil)
				
			}
		}
	}
	
	private func configureTableNode() {
		tableNode.delegate = self
		tableNode.dataSource = self
		tableNode.backgroundColor = .init(white: 0.11, alpha: 1)
		tableNode.contentInset.top = 8.0
		tableNode.view.tableFooterView = UIView()
	}
}

extension NewsListNode: ASTableDelegate, ASTableDataSource {
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return isLoading ? (viewModel.articles.count + 1) : viewModel.articles.count
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		
		guard indexPath.row < viewModel.articles.count else {
			return NewsListLoadingCellNode()
		}
		
		let cell = NewsListCellNode(article: viewModel.articles[indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: ASTableView, willDisplay node: ASCellNode, forRowAt indexPath: IndexPath) {
		
		guard !isLoading else {
			return
		}
		
		if indexPath.row == viewModel.articles.count - 1 {
			
			if viewModel.articles.count + viewModel.itemsPerPage <= viewModel.totalResult {
				currentPage += 1
				DispatchQueue.main.async { [weak self] in
					
					guard let self = self else {
						return
					}
					
					self.tableNode.performBatchUpdates({
						self.isLoading = true
						self.tableNode.insertRows(at: [IndexPath(row: self.viewModel.lastArticlesCount, section: 0)], with: .fade)
					}, completion: { _ in
						self.viewModel.loadData(for: self.currentPage)
					})
				}
			}
		}
	}
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		
		guard indexPath.row < viewModel.articles.count else {
			return
		}
		
		tableNode.deselectRow(at: indexPath, animated: true)
		onTapNews?(viewModel.articles[indexPath.row].url)
	}
	
}

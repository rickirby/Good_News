//
//  HomeNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import AsyncDisplayKit

class HomeNode: ASDisplayNode {
	
	var onTapNews: (() -> Void)?
	
	private let viewModel: HomeViewModel
	
	private lazy var tableNode: ASTableNode = ASTableNode(style: .plain)
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		
		super.init()
		automaticallyManagesSubnodes = true
		
		configureTableNode()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		return ASWrapperLayoutSpec(layoutElement: tableNode)
	}
	
	private func configureTableNode() {
		tableNode.delegate = self
		tableNode.dataSource = self
		tableNode.backgroundColor = .init(white: 0.11, alpha: 1)
		tableNode.view.separatorStyle = .none
	}
	
	private func makeHeaderNode() -> ASCellNode {
		let node = HomeHeaderNode(viewModel: viewModel.headerViewModel)
		
		return node
	}
	
	private func makeWeatherNode() -> ASCellNode {
		let node = HomeWeatherNode(viewModel: viewModel.weatherViewModel)
		
		return node
	}
	
	private func makeNewsNode() -> ASCellNode {
		let node = HomeNewsNode(viewModel: viewModel.newsViewModel)
		
		return node
	}
	
	private func makeTableCellNode(indexPath: IndexPath) -> ASCellNode {
		switch indexPath.row {
		case 0:
			return makeHeaderNode()
		case 1:
			return makeWeatherNode()
		case 2:
			return makeNewsNode()
		default:
			return ASCellNode()
		}
	}
	
}

extension HomeNode: ASTableDelegate, ASTableDataSource {
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		return makeTableCellNode(indexPath: indexPath)
	}
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 2:
			if !viewModel.newsViewModel.isSkeleton {
				onTapNews?()
			}
			
		default:
			break
		}
	}
	
	func tableNode(_ tableNode: ASTableNode, didHighlightRowAt indexPath: IndexPath) {
		
		guard indexPath.row != 0 else {
			return
		}
		
		let node = tableNode.nodeForRow(at: indexPath)
		
		UIView.animate(withDuration: 0.15) {
			node?.transform = CATransform3DMakeScale(0.97, 0.98, 1)
		}
	}
	
	func tableNode(_ tableNode: ASTableNode, didUnhighlightRowAt indexPath: IndexPath) {
		
		guard indexPath.row != 0 else {
			return
		}
		
		let node = tableNode.nodeForRow(at: indexPath)
		
		UIView.animate(withDuration: 0.15) {
			node?.transform = CATransform3DMakeScale(1, 1, 1)
		}
	}
}

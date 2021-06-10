//
//  HomeNewsNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import AsyncDisplayKit

class HomeNewsNode: ASCellNode {
	
	private var contentNode: HomeNewsContentNode
	
	private var sideInset: CGFloat = 20.0
	private var squareWidth: CGFloat {
		return DeviceSize.screenWidth - (2 * sideInset)
	}
	
	private let viewModel: HomeNewsViewModel
	
	init(viewModel: HomeNewsViewModel) {
		self.viewModel = viewModel
		self.contentNode = HomeNewsContentNode(viewModel: viewModel)
		
		super.init()
		backgroundColor = .clear
		selectionStyle = .none
		automaticallyManagesSubnodes = true
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		contentNode.style.preferredSize = CGSize(width: squareWidth, height: squareWidth)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: sideInset, bottom: 16, right: sideInset), child: contentNode)
	}
}

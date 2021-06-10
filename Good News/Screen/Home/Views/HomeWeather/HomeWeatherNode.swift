//
//  HomeWeatherNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import AsyncDisplayKit

class HomeWeatherNode: ASCellNode {
	
	private var contentNode: HomeWeatherContentNode
	
	private var sideInset: CGFloat = 20.0
	private var squareWidth: CGFloat {
		return DeviceSize.screenWidth - (2 * sideInset)
	}
	
	private let viewModel: HomeWeatherViewModel
	
	init(viewModel: HomeWeatherViewModel) {
		self.viewModel = viewModel
		self.contentNode = HomeWeatherContentNode(viewModel: viewModel)
		
		super.init()
		backgroundColor = .clear
		selectionStyle = .none
		automaticallyManagesSubnodes = true
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		contentNode.style.preferredSize = CGSize(width: squareWidth, height: 0.75 * squareWidth)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: sideInset, bottom: 16, right: sideInset), child: contentNode)
	}
	
}

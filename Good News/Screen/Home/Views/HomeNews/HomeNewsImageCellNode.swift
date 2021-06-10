//
//  HomeNewsImageCellNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import AsyncDisplayKit

class HomeNewsImageCellNode: ASCellNode {
	
	private lazy var imageNode: ASNetworkImageNode = ASNetworkImageNode()
	
	init(imageUrl: String) {
		super.init()
		automaticallyManagesSubnodes = true
		
		configureImageNode()
		displayImage(with: imageUrl)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		return ASWrapperLayoutSpec(layoutElement: imageNode)
	}
	
	private func configureImageNode() {
		imageNode.placeholderColor = .lightGray
	}
	
	private func displayImage(with imageUrl: String) {
		if imageUrl.contains("https") {
			imageNode.url = URL(string: imageUrl)
		} else {
			imageNode.image = UIImage(named: imageUrl)
		}
	}
}

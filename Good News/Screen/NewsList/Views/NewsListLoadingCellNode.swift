//
//  NewsListLoadingCellNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit

class NewsListLoadingCellNode: ASCellNode {
	
	private lazy var loadingNode: ASDisplayNode = ASDisplayNode { () -> UIView in
		let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
		activityIndicator.color = .lightGray
		activityIndicator.backgroundColor = .clear
		activityIndicator.startAnimating()
		
		return activityIndicator
	}
	
	override init() {
		super.init()
		backgroundColor = .clear
		automaticallyManagesSubnodes = true
		selectionStyle = .none
		separatorInset = UIEdgeInsets(top: 0, left: DeviceSize.screenWidth / 2 , bottom: 0, right: DeviceSize.screenWidth / 2)
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		loadingNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 24)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 0, bottom: 16.0, right: 0), child: loadingNode)
	}
	
}

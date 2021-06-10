//
//  NewsListCellNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit

class NewsListCellNode: ASCellNode {
	
	private lazy var titleNode: ASTextNode = ASTextNode()
	private lazy var descriptionNode: ASTextNode = ASTextNode()
	
	init(article: NewsArticleResObject) {
		
		super.init()
		backgroundColor = .clear
		automaticallyManagesSubnodes = true
		accessoryType = .disclosureIndicator
		
		configureTitleNode()
		configureDescriptionNode()
		displayTextData(article: article)
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let mainStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 8.0,
			justifyContent: .start,
			alignItems: .start,
			children: [titleNode, descriptionNode]
		)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 24.0, bottom: 8.0, right: 24.0), child: mainStack)
	}
	
	private func configureTitleNode() {
		titleNode.maximumNumberOfLines = 2
		titleNode.truncationMode = .byTruncatingTail
	}
	
	private func configureDescriptionNode() {
		descriptionNode.maximumNumberOfLines = 2
		descriptionNode.truncationMode = .byTruncatingTail
	}
	
	private func displayTextData(article: NewsArticleResObject) {
		let titleStyle = TextStyle(size: 18, weight: .medium, color: .white)
		let descriptionStyle = TextStyle(size: 14, weight: .light, color: .lightGray)
		
		titleNode.attributedText = titleStyle.getText(from: article.title)
		descriptionNode.attributedText = descriptionStyle.getText(from: article.content)
	}
}

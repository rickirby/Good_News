//
//  HomeHeaderNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import AsyncDisplayKit

class HomeHeaderNode: ASCellNode {
	
	private lazy var calendarTextNode: ASTextNode = ASTextNode()
	private lazy var todayTextNode: ASTextNode = ASTextNode()
	private lazy var profileImageNode: ASImageNode = ASImageNode()
	
	private let viewModel: HomeHeaderViewModel
	
	init(viewModel: HomeHeaderViewModel) {
		self.viewModel = viewModel
		
		super.init()
		backgroundColor = .clear
		selectionStyle = .none
		automaticallyManagesSubnodes = true
		
		displayData()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		profileImageNode.style.preferredSize = CGSize(width: 32, height: 32)
		
		let leftStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 4.0,
			justifyContent: .center,
			alignItems: .start,
			children: [
				calendarTextNode,
				todayTextNode
			]
		)
		
		let mainStack = ASStackLayoutSpec(
			direction: .horizontal,
			spacing: 0,
			justifyContent: .spaceBetween,
			alignItems: .end,
			children: [
				leftStack,
				profileImageNode
			]
		)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 8, right: 20), child: mainStack)
	}
	
	private func displayData() {
		displayCalendarTextNode()
		displayTodayTextNode()
		displayProfileImageNode()
	}
	
	private func displayCalendarTextNode() {
		let textStyle = TextStyle(size: 14, weight: .medium, color: .lightGray)
		calendarTextNode.attributedText = textStyle.getText(from: viewModel.getFormattedDate())
	}
	
	private func displayTodayTextNode() {
		let textStyle = TextStyle(size: 28, weight: .bold, color: .white)
		todayTextNode.attributedText = textStyle.getText(from: "Today")
	}
	
	private func displayProfileImageNode() {
		profileImageNode.image = UIImage(named: "avatar")
	}
	
}

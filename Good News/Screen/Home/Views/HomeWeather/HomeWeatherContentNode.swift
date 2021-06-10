//
//  HomeWeatherContentNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import AsyncDisplayKit

class HomeWeatherContentNode: ASDisplayNode {
	
	private lazy var cityTextNode: ASTextNode = ASTextNode()
	private lazy var tempTextNode: ASTextNode = ASTextNode()
	private lazy var tempImageNode: ASNetworkImageNode = ASNetworkImageNode()
	private lazy var tempDescriptionTextNode: ASTextNode = ASTextNode()
	private lazy var humidityTextNode: ASTextNode = ASTextNode()
	private lazy var pressureTextNode: ASTextNode = ASTextNode()
	
	private lazy var citySkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var tempSkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var tempDescriptionSkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var parameterSkeletonNode: SkeletonNode = SkeletonNode()
	
	private let citySkeletonSize: CGSize = CGSize(width: 0.2 * DeviceSize.screenWidth, height: 28)
	private let tempSkeletonSize: CGSize = CGSize(width: 0.45 * DeviceSize.screenWidth, height: 72)
	private let tempDescriptionSkeletonSize: CGSize = CGSize(width: 0.2 * DeviceSize.screenWidth, height: 18)
	private let parameterSkeletonSize: CGSize = CGSize(width: 0.4 * DeviceSize.screenWidth, height: 14)
	
	let viewModel: HomeWeatherViewModel
	
	init(viewModel: HomeWeatherViewModel) {
		self.viewModel = viewModel
		
		super.init()
		
		backgroundColor = .init(white: 0.25, alpha: 1)
		cornerRadius = 20.0
		automaticallyManagesSubnodes = true
		
		configureViewModel()
		displayData()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		citySkeletonNode.style.preferredSize = citySkeletonSize
		tempSkeletonNode.style.preferredSize = tempSkeletonSize
		tempDescriptionSkeletonNode.style.preferredSize = tempDescriptionSkeletonSize
		parameterSkeletonNode.style.preferredSize = parameterSkeletonSize
		
		tempImageNode.style.preferredSize = CGSize(width: 44.0, height: 44.0)
		
		let topSkeletonStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 8,
			justifyContent: .start,
			alignItems: .start,
			children: [
				citySkeletonNode,
				tempSkeletonNode
			]
		)
		
		let bottomSkeletonStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 8,
			justifyContent: .start,
			alignItems: .start,
			children: [
				tempDescriptionSkeletonNode,
				parameterSkeletonNode
			]
		)
		
		let mainSkeletonStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 0,
			justifyContent: .spaceBetween,
			alignItems: .start,
			children: [
				topSkeletonStack,
				bottomSkeletonStack
			]
		)
		
		let topStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 0,
			justifyContent: .start,
			alignItems: .start,
			children: [
				cityTextNode,
				tempTextNode
			]
		)
		
		let detailStack = ASStackLayoutSpec(
			direction: .horizontal,
			spacing: 12.0,
			justifyContent: .start,
			alignItems: .start,
			children: [
				humidityTextNode,
				pressureTextNode
			]
		)
		
		let bottomStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 0,
			justifyContent: .start,
			alignItems: .start,
			children: [
				tempImageNode,
				tempDescriptionTextNode,
				detailStack
			]
		)
		
		let mainStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 0,
			justifyContent: .spaceBetween,
			alignItems: .start,
			children: [
				topStack,
				bottomStack
			]
		)
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24), child: viewModel.isSkeleton ? mainSkeletonStack : mainStack)
	}
	
	private func configureViewModel() {
		viewModel.onNeedRefresh = { [weak self] in
			self?.viewModel.isSkeleton = false
			self?.displayData()
			self?.setNeedsLayout()
		}
	}
	
	private func displayData() {
		displayCityTextNode()
		displayTempTextNode()
		displayTempImageNode()
		displayTempDescriptionTextNode()
		displayHumidityTextNode()
		displayPressureTextNode()
	}
	
	private func displayCityTextNode() {
		let textStyle = TextStyle(size: 28, weight: .medium, color: .white)
		cityTextNode.attributedText = textStyle.getText(from: viewModel.cityName)
	}
	
	private func displayTempTextNode() {
		let textStyle = TextStyle(size: 72, weight: .light, color: .white)
		let temperature = String(format: "%.1f", viewModel.temperature)
		tempTextNode.attributedText = textStyle.getText(from: "\(temperature)℃")
	}
	
	private func displayTempImageNode() {
		tempImageNode.url = getTempIconUrl()
	}
	
	private func displayTempDescriptionTextNode() {
		let textStyle = TextStyle(size: 18, weight: .light, color: .white)
		tempDescriptionTextNode.attributedText = textStyle.getText(from: viewModel.temperatureDescription.capitalized)
	}
	
	private func displayHumidityTextNode() {
		let textStyle = TextStyle(size: 14, weight: .light, color: .white)
		humidityTextNode.attributedText = textStyle.getText(from: "H: \(viewModel.humidity)%")
	}
	
	private func displayPressureTextNode() {
		let textStyle = TextStyle(size: 14, weight: .light, color: .white)
		pressureTextNode.attributedText = textStyle.getText(from: "P: \(viewModel.pressure) hPa")
	}
	
	private func getTempIconUrl() -> URL? {
		let urlString = GoodNewsConstant.openWeatherIconUrl
			.replacingOccurrences(of: "<code>", with: viewModel.temperatureIconCode)
		return URL(string: urlString)
	}
}

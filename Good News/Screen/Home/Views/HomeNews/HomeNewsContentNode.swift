//
//  HomeNewsContentNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import AsyncDisplayKit
import Shimmer

class HomeNewsContentNode: ASDisplayNode {
	
	private lazy var collectionNode: ASCollectionNode = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		let collectionNode = ASCollectionNode(collectionViewLayout: layout)
		
		return collectionNode
	}()
	
	private lazy var titleNode: ASTextNode = ASTextNode()
	private lazy var descriptionNode: ASTextNode = ASTextNode()
	
	private lazy var collectionSkeletonNode: SkeletonNode = SkeletonNode(cornerRadius: 0)
	private lazy var titleSkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var title2SkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var descriptionSkeletonNode: SkeletonNode = SkeletonNode()
	private lazy var description2SkeletonNode: SkeletonNode = SkeletonNode()
	
	private var collectionNodeSize: CGSize {
		return CGSize(width: style.preferredSize.width, height: 0.65 * style.preferredSize.width)
	}
	private let titleSkeletonSize: CGSize = CGSize(width: 0.5 * DeviceSize.screenWidth, height: 20)
	private let descriptionSkeletonSize: CGSize = CGSize(width: 0.8 * DeviceSize.screenWidth, height: 14)
	
	private var timer: Timer?
	private var currentIndex: Int = 0
	
	private let viewModel: HomeNewsViewModel
	
	init(viewModel: HomeNewsViewModel) {
		self.viewModel = viewModel
		
		super.init()
		backgroundColor = .init(white: 0.25, alpha: 1)
		cornerRadius = 20.0
		clipsToBounds = true
		automaticallyManagesSubnodes = true
		
		configureViewModel()
		configureCollectionNode()
		configureTitleNode()
		configureDescriptionNode()
		
		displayData()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		collectionSkeletonNode.style.preferredSize = collectionNodeSize
		titleSkeletonNode.style.preferredSize = titleSkeletonSize
		title2SkeletonNode.style.preferredSize = titleSkeletonSize
		descriptionSkeletonNode.style.preferredSize = descriptionSkeletonSize
		description2SkeletonNode.style.preferredSize = descriptionSkeletonSize
		
		collectionNode.style.preferredSize = collectionNodeSize
		
		let textSkeletonStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 8.0,
			justifyContent: .start,
			alignItems: .start,
			children: [titleSkeletonNode, title2SkeletonNode, descriptionSkeletonNode, description2SkeletonNode]
		)
		
		let textSkeletonStackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16), child: textSkeletonStack)
		
		let mainSkeletonStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 16.0,
			justifyContent: .start,
			alignItems: .start,
			children: [collectionSkeletonNode, textSkeletonStackInset]
		)
		
		let textStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 8.0,
			justifyContent: .start,
			alignItems: .start,
			children: [titleNode, descriptionNode]
		)
		
		let textStackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16), child: textStack)
		
		let mainStack = ASStackLayoutSpec(
			direction: .vertical,
			spacing: 16.0,
			justifyContent: .start,
			alignItems: .start,
			children: [collectionNode, textStackInset]
		)
		
		return viewModel.isSkeleton ? mainSkeletonStack : mainStack
	}
	
	private func configureViewModel() {
		viewModel.onNeedRefresh = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				
				self?.collectionNode.reloadData(completion: { [weak self] in
					self?.setNeedsLayout()
					self?.startLooping()
				})
			}
		}
	}
	
	private func configureCollectionNode() {
		collectionNode.delegate = self
		collectionNode.dataSource = self
		collectionNode.backgroundColor = .clear
		collectionNode.isPagingEnabled = true
		collectionNode.view.isScrollEnabled = false
		collectionNode.view.showsVerticalScrollIndicator = false
		collectionNode.isUserInteractionEnabled = false
	}
	
	private func configureTitleNode() {
		titleNode.maximumNumberOfLines = 2
		titleNode.truncationMode = .byTruncatingTail
	}
	
	private func configureDescriptionNode() {
		descriptionNode.maximumNumberOfLines = 2
		descriptionNode.truncationMode = .byTruncatingTail
	}
	
	private func startLooping() {
		timer?.invalidate()
		
		currentIndex = 0
		displayData()
		
		timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
			
			guard let self = self else {
				return
			}
			
			let articles = self.viewModel.getFirstFiveArticles()
			
			guard self.currentIndex < articles.count else {
				return
			}
			
			self.displayData()
		}
	}
	
	private func displayData() {
		
		let articles = viewModel.getFirstFiveArticles()
		
		guard currentIndex < articles.count else {
			return
		}
		
		displayTextData(article: articles[currentIndex])
		scrollToPage(page: currentIndex)
		
		currentIndex += 1
		if currentIndex >= articles.count {
			self.currentIndex = 0
		}
	}
	
	private func displayTextData(article: NewsArticleResObject) {
		let titleStyle = TextStyle(size: 20, weight: .medium, color: .white)
		let descriptionStyle = TextStyle(size: 14, weight: .light, color: .lightGray)
		
		titleNode.attributedText = titleStyle.getText(from: article.title)
		descriptionNode.attributedText = descriptionStyle.getText(from: article.content)
	}
	
	private func scrollToPage(page: Int) {
		collectionNode.scrollToItem(at: IndexPath(row: page, section: 0), at: .left, animated: true)
	}
}

extension HomeNewsContentNode: ASCollectionDelegate, ASCollectionDataSource {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		return viewModel.getFirstFiveArticles().count
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let articles = viewModel.getFirstFiveArticles()
		
		guard indexPath.row < articles.count else {
			return ASCellNode()
		}
		
		let cell = HomeNewsImageCellNode(imageUrl: articles[indexPath.row].urlToImage)
		
		return cell
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
		return ASSizeRange(min: .zero, max: collectionNodeSize)
	}
	
}

//
//  SkeletonNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 10/06/21.
//

import AsyncDisplayKit
import Shimmer

class SkeletonNode: ASDisplayNode {
	
	private var shimmeringView: FBShimmeringView?
	
	init(cornerRadius: CGFloat = 5.0) {
		
		super.init()
		self.backgroundColor = .lightGray
		self.cornerRadius = cornerRadius
		
		DispatchQueue.main.async { [weak self] in
			
			guard let self = self else {
				return
			}
			
			self.shimmeringView = FBShimmeringView(frame: CGRect(origin: .zero, size: CGSize(width: DeviceSize.screenWidth, height: DeviceSize.screenHeight)))
			self.shimmeringView?.isShimmering = true
			self.shimmeringView?.contentView = self.view
			self.shimmeringView?.shimmeringSpeed = 600
		}
	}
}

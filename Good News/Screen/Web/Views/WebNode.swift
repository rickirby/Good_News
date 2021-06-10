//
//  WebNode.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit
import WebKit

class WebNode: ASDisplayNode {
	
	lazy var webView: WKWebView = {
		let webConfiguration = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.backgroundColor = .white
		
		return webView
	}()
	
	private lazy var webNode: ASDisplayNode = {
		return ASDisplayNode { [weak self] () -> UIView in
			
			guard let self = self else {
				return UIView()
			}
			
			return self.webView
		}
	}()
	
	override init() {
		super.init()
		automaticallyManagesSubnodes = true
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		return ASWrapperLayoutSpec(layoutElement: webNode)
	}
	
}

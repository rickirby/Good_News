//
//  WebViewController.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import AsyncDisplayKit
import WebKit

class WebViewController: ASDKViewController<ASDisplayNode> {
	
	lazy var progressView: UIProgressView = UIProgressView(progressViewStyle: .default)
	
	var estimatedProgressObserver: NSKeyValueObservation?
	var titleObserver: NSKeyValueObservation?
	
	private let urlString: String
	private let mainNode: WebNode
	
	init(url urlString: String) {
		self.urlString = urlString
		self.mainNode = WebNode()
		
		super.init(node: mainNode)
		
		configureObserver()
		configureWebview()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureProgressView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		progressView.removeFromSuperview()
	}
	
	private func configureProgressView() {
		guard let navigationBar = navigationController?.navigationBar else { return }
		
		progressView.translatesAutoresizingMaskIntoConstraints = false
		navigationBar.addSubview(progressView)
		
		progressView.isHidden = true
		
		NSLayoutConstraint.activate([
			progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
			progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
			
			progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
			progressView.heightAnchor.constraint(equalToConstant: 3.0)
		])
	}
	
	private func configureObserver() {
		estimatedProgressObserver = mainNode.webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
			self?.progressView.progress = Float(webView.estimatedProgress)
		}
		
		titleObserver = mainNode.webView.observe(\.title, options: [.new]) { [weak self] webView, _ in
			self?.title = webView.title
		}
	}
	
	private func configureWebview() {
		mainNode.webView.navigationDelegate = self
		
		if let url = URL(string: urlString) {
			let request = URLRequest(url: url)
			mainNode.webView.load(request)
		}
	}
	
}

extension WebViewController: WKNavigationDelegate {
	func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
		if progressView.isHidden {
			progressView.isHidden = false
		}
		
		UIView.animate(withDuration: 0.33,
					   animations: { [weak self] in
						self?.progressView.alpha = 1.0
					   })
	}
	
	func webView(_: WKWebView, didFinish _: WKNavigation!) {
		UIView.animate(withDuration: 0.33,
					   animations: { [weak self] in
						self?.progressView.alpha = 0.0
					   },
					   completion: { [weak self] isFinished in
						self?.progressView.isHidden = isFinished
					   })
	}
	
}

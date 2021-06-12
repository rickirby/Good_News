//
//  HomeNewsViewModel.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeNewsViewModel {
	
	var onNeedRefresh: (() -> Void)?
	
	var articles: [NewsArticleResObject] = []
	
	var isSkeleton: Bool = true
	var isSuccess: Bool = false
	var totalResult: Int = 0
	let itemsPerPage: Int = 10
	
	private let newsService: NewsServiceProtocol
	private let disposeBag = DisposeBag()
	
	init(newsService: NewsServiceProtocol = NewsService()) {
		self.newsService = newsService
	}
	
	func loadData() {
		newsService.getNewsData(topic: "covid", itemsPerPage: itemsPerPage, page: 1)
			.subscribe(onNext: { [weak self] result in
				self?.totalResult = result.totalResults
				self?.articles = result.articles
				
				self?.isSkeleton = false
				self?.isSuccess = true
				self?.onNeedRefresh?()
			}, onError: { [weak self] error in
				if let error = error as? HTTPStatusCode {
					self?.articles = [NewsArticleResObject(title: "Error", content: "Error happened with status code \(error.rawValue) (\(error.description))", url: "", urlToImage: "ap_paper")]
				} else {
					self?.articles = [NewsArticleResObject(title: "Error", content: error.localizedDescription, url: "", urlToImage: "ap_paper")]
				}
				
				self?.isSkeleton = false
				self?.isSuccess = false
				self?.onNeedRefresh?()
			})
			.disposed(by: disposeBag)
	}
	
	func getFirstFiveArticles() -> [NewsArticleResObject] {
		return Array(articles.prefix(5))
	}
	
}

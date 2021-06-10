//
//  NewsListViewModel.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 09/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class NewsListViewModel {
	
	var onNeedRefresh: (() -> Void)?
	
	var articles: [NewsArticleResObject] = []
	
	// NOTE: Since the API is in developer mode, it can only fetch max 100 articles, I limit it into 40
	var totalResult: Int = 0 {
		didSet {
			if totalResult > 40 {
				totalResult = 40
			}
		}
	}
	var lastArticlesCount: Int = 0
	let itemsPerPage: Int = 10
	
	private let newsService: NewsServiceProtocol
	private let disposeBag = DisposeBag()
	
	init(newsService: NewsServiceProtocol = NewsService()) {
		self.newsService = newsService
	}
	
	func loadData(for page: Int) {
		newsService.getNewsData(topic: "covid", itemsPerPage: itemsPerPage, page: page)
			.subscribe(onNext: { [weak self] result in
				self?.totalResult = result.totalResults
				self?.articles.append(contentsOf: result.articles)
				self?.onNeedRefresh?()
			}, onError: { [weak self] error in
				self?.onNeedRefresh?()
			})
			.disposed(by: disposeBag)
	}
}

//
//  MockNewsService.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 08/06/21.
//

import Foundation
import RxSwift
import RxCocoa

@testable
import Good_News

class MockNewsService: NewsServiceProtocol {
	
	var testSchemeSuccess: Bool = true
	
	func getNewsData(topic: String, itemsPerPage: Int, page: Int) -> Observable<NewsResResult> {
		return Observable.create { [weak self] observer -> Disposable in
			if self?.testSchemeSuccess == true {
				let article = NewsArticleResObject(title: "test", content: "test", url: "test", urlToImage: "test")
				let newsResult = NewsResResult(totalResults: 1, articles: [article])
				
				observer.onNext(newsResult)
			} else {
				observer.onError(HTTPStatusCode.notFound)
			}
			return Disposables.create()
		}
	}
}

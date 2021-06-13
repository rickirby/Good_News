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
	var testNewsResult: NewsResResult = NewsResResult(totalResults: 0, articles: [])
	
	func getNewsData(topic: String, itemsPerPage: Int, page: Int) -> Observable<NewsResResult> {
		return Observable.create { [weak self] observer -> Disposable in
			if self?.testSchemeSuccess == true, let newsResult = self?.testNewsResult {
				observer.onNext(newsResult)
			} else {
				observer.onError(HTTPStatusCode.notFound)
			}
			return Disposables.create()
		}
	}
}

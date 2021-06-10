//
//  NewsService.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class NewsService: NewsServiceProtocol {
	func getNewsData(topic: String, itemsPerPage: Int, page: Int) -> Observable<NewsResResult> {
		
		let request = NewsRequest(q: topic, pageSize: itemsPerPage, page: page, apiKey: GoodNewsConstant.newsApiKey)
		
		let service = APIService<NewsRequest, NewsResResult>(req: request)
		service.baseUrl = GoodNewsConstant.newsApiBaseUrl
		service.path = GoodNewsConstant.newsApiPath
		
		return service.load()
	}
	
	
}

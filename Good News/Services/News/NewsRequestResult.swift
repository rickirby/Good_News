//
//  NewsRequestResult.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import Foundation

struct NewsRequest: Encodable {
	var q: String
	var pageSize: Int
	var page: Int
	var apiKey: String
}

struct NewsResResult: Decodable {
	var totalResults: Int
	var articles: [NewsArticleResObject]
}

struct NewsArticleResObject: Decodable {
	var title: String
	var content: String
	var url: String
	var urlToImage: String
}

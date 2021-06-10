//
//  NewsServiceProtocol.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 07/06/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsServiceProtocol {
	func getNewsData(topic: String, itemsPerPage: Int, page: Int) -> Observable<NewsResResult>
}

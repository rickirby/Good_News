//
//  APIService.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class APIService<Req: Encodable, Res: Decodable> {
	
	var baseUrl: String? {
		didSet {
			urlComponents.host = baseUrl
		}
	}
	
	var path: String = "" {
		didSet {
			urlComponents.path = path
		}
	}
	
	private var urlComponents: URLComponents = {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		
		return urlComponents
	}()
	
	private var url: URL {
		guard let url = urlComponents.url else {
			return URL(string: "")!
		}
		
		return url
	}
	
	init(req: Req) {
		urlComponents.setQueryItems(with: req.dictionary)
	}
	
	func load() -> Observable<Res> {
		return Observable.just(url)
			.flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
				let request = URLRequest(url: url)
				return URLSession.shared.rx.response(request: request)
			}.map { (res, data) -> Res in
				if res.status?.responseType == .success {
					return try JSONDecoder().decode(Res.self, from: data)
				} else {
					throw res.status ?? HTTPStatusCode.undefinedError
				}
			}
	}
	
}

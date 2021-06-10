//
//  HomeNewsViewModelSpec.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 08/06/21.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable
import Good_News

class HomeNewsViewModelSpec: QuickSpec {
	
	override func spec() {
		var mockNewsService: MockNewsService!
		var viewModel: HomeNewsViewModel!
		
		beforeEach {
			mockNewsService = MockNewsService()
			viewModel = HomeNewsViewModel(newsService: mockNewsService)
		}
		
		afterEach {
			mockNewsService = nil
			viewModel = nil
		}
		
		describe("On call") {
			context("loadData") {
				it("On success scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockNewsService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData()
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On success scheme, should got expected mock service value") {
					var article: [NewsArticleResObject] = []
					
					mockNewsService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						article = viewModel.articles
					}
					viewModel.loadData()
					
					expect(article.count).to(equal(1))
					expect(article.first?.title).to(equal("test"))
				}
				
				it("On error scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockNewsService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData()
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On error scheme, should got expected mock service value") {
					var article: [NewsArticleResObject] = []
					
					mockNewsService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						article = viewModel.articles
					}
					viewModel.loadData()
					
					expect(article.count).to(equal(1))
					expect(article.first?.title).to(equal("Error"))
					expect(article.first?.content).to(equal("Something error happened"))
					expect(article.first?.urlToImage).to(equal("ap_paper"))
				}
			}
		}
	}
}

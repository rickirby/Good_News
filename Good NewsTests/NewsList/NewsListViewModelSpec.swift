//
//  NewsListViewModelSpec.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 10/06/21.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable
import Good_News

class NewsListViewModelSpec: QuickSpec {
	
	override func spec() {
		var mockNewsService: MockNewsService!
		var viewModel: NewsListViewModel!
		
		beforeEach {
			mockNewsService = MockNewsService()
			viewModel = NewsListViewModel(newsService: mockNewsService)
		}
		
		afterEach {
			mockNewsService = nil
			viewModel = nil
		}
		
		describe("On set") {
			context("totalResult") {
				it("On less than 40 should be as it is") {
					viewModel.totalResult = 10
					
					expect(viewModel.totalResult).to(equal(10))
				}
				
				it("On more than 40 should be limited to 40") {
					viewModel.totalResult = 100
					
					expect(viewModel.totalResult).to(equal(40))
				}
			}
			
			context("loadData") {
				it("On success scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockNewsService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData(for: 1)
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On success scheme, should got expected mock service value") {
					var article: [NewsArticleResObject] = []
					
					mockNewsService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						article = viewModel.articles
					}
					viewModel.loadData(for: 1)
					
					expect(article.count).to(equal(1))
					expect(article.first?.title).to(equal("test"))
				}
				
				it("On error scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockNewsService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData(for: 1)
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On error scheme, should got expected mock service value") {
					var article: [NewsArticleResObject] = []
					
					mockNewsService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						article = viewModel.articles
					}
					viewModel.loadData(for: 1)
					
					expect(article.count).to(equal(0))
				}
			}
		}
	}
}

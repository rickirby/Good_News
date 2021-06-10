//
//  HomeHeaderViewModelSpec.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Quick
import Nimble

@testable
import Good_News

class HomeHeaderViewModelSpec: QuickSpec {
	
	override func spec() {
		
		var viewModel: HomeHeaderViewModel!
		
		beforeEach {
			viewModel = HomeHeaderViewModel()
		}
		
		afterEach {
			viewModel = nil
		}
		
		describe("On call") {
			context("getFormattedDate") {
				it("Should return correct format") {
					let formatter = DateFormatter()
					formatter.dateFormat = "dd-MM-yyy"
					
					if let date = formatter.date(from: "01-01-2021") {
						expect(viewModel.getFormattedDate(from: date)).to(equal("FRIDAY 1 JANUARY"))
					}
				}
			}
		}
	}
}

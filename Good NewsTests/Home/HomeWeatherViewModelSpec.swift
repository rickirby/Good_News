//
//  HomeWeatherViewModelSpec.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable
import Good_News

class HomeWeatherViewModelSpec: QuickSpec {
	
	override func spec() {
		
		var mockWeatherService: MockWeatherService!
		var viewModel: HomeWeatherViewModel!
		
		beforeEach {
			mockWeatherService = MockWeatherService()
			viewModel = HomeWeatherViewModel(weatherService: mockWeatherService)
		}
		
		afterEach {
			mockWeatherService = nil
			viewModel = nil
		}
		
		describe("On call") {
			context("loadData") {
				it("On success scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockWeatherService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData()
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On success scheme, should got expected mock service value") {
					var gotName = ""
					var gotDescription = ""
					var gotIcon = ""
					var gotTemp = 0.0
					var gotPressure = 0
					var gotHumidity = 0
					
					mockWeatherService.testSchemeSuccess = true
					viewModel.onNeedRefresh = {
						gotName = viewModel.cityName
						gotDescription = viewModel.temperatureDescription
						gotIcon = viewModel.temperatureIconCode
						gotTemp = viewModel.temperature
						gotPressure = viewModel.pressure
						gotHumidity = viewModel.humidity
					}
					viewModel.loadData()
					
					expect(gotName).to(equal("test"))
					expect(gotDescription).to(equal("test"))
					expect(gotIcon).to(equal("test"))
					expect(gotTemp).to(equal(99.0))
					expect(gotPressure).to(equal(99))
					expect(gotHumidity).to(equal(99))
				}
				
				it("On error scheme, should call onNeedRefresh closure") {
					var isRefreshCalled = false
					
					mockWeatherService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						isRefreshCalled = true
					}
					viewModel.loadData()
					
					expect(isRefreshCalled).to(beTrue())
				}
				
				it("On error scheme, should got expected error value") {
					var gotName = ""
					var gotDescription = ""
					var gotIcon = ""
					var gotTemp = 0.0
					var gotPressure = 0
					var gotHumidity = 0
					
					mockWeatherService.testSchemeSuccess = false
					viewModel.onNeedRefresh = {
						gotName = viewModel.cityName
						gotDescription = viewModel.temperatureDescription
						gotIcon = viewModel.temperatureIconCode
						gotTemp = viewModel.temperature
						gotPressure = viewModel.pressure
						gotHumidity = viewModel.humidity
					}
					viewModel.loadData()
					
					expect(gotName).to(equal("Error"))
					expect(gotDescription).to(equal("Something Error Happened"))
					expect(gotIcon).to(equal(""))
					expect(gotTemp).to(equal(0))
					expect(gotPressure).to(equal(0))
					expect(gotHumidity).to(equal(0))
				}
			}
		}
	}
}

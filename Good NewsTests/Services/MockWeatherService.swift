//
//  MockWeatherService.swift
//  Good NewsTests
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

@testable
import Good_News

class MockWeatherService: WeatherServiceProtocol {
	
	var testSchemeSuccess: Bool = true
	
	func getWeatherData(location: CLLocation) -> Observable<WeatherResResult> {
		return Observable.create { [weak self] observer -> Disposable in
			if self?.testSchemeSuccess == true {
				let weatherResResult = WeatherResResult(name: "test", weather: [WeatherWeatherResObject(description: "test", icon: "test")], main: WeatherMainResObject(temp: 372.0, pressure: 99, humidity: 99))
				observer.onNext(weatherResResult)
			} else {
				observer.onError(HTTPStatusCode.notFound)
			}
			return Disposables.create()
		}
	}
}

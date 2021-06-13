//
//  HomeWeatherViewModel.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class HomeWeatherViewModel {
	
	var onNeedRefresh: (() -> Void)?
	
	var isSkeleton: Bool = true
	var cityName: String = ""
	var temperature: Double = 0
	var temperatureDescription: String = ""
	var temperatureIconCode: String = ""
	var humidity: Int = 0
	var pressure: Int = 0
	var location: CLLocation = {
		
		guard let lat = CLLocationDegrees(GoodNewsConstant.jakartaLatitude), let lon = CLLocationDegrees(GoodNewsConstant.jakartaLongitude) else {
			return CLLocation()
		}
		
		return CLLocation(latitude: lat, longitude: lon)
	}()
	
	private let weatherService: WeatherServiceProtocol
	private let disposeBag = DisposeBag()
	
	// TODO: - Improve to user CLLocationManager to get user's location
	init(weatherService: WeatherServiceProtocol = WeatherService()) {
		self.weatherService = weatherService
	}
	
	func loadData() {
		weatherService.getWeatherData(location: location)
			.subscribe(
				onNext: { [weak self] result in
					self?.cityName = result.name
					self?.temperature = result.main.temp - 273
					self?.humidity = result.main.humidity
					self?.pressure = result.main.pressure
					
					if let weatherDescription = result.weather.first {
						self?.temperatureDescription = weatherDescription.description.capitalized
						self?.temperatureIconCode = weatherDescription.icon
					}
					
					self?.onNeedRefresh?()
				},
				onError: { [weak self] error in
					self?.displayError(error: error)
				}
			)
			.disposed(by: disposeBag)
	}
	
	private func displayError(error: Error) {
		
		cityName = "Error"
		temperature = 0
		temperatureIconCode = ""
		humidity = 0
		pressure = 0
		
		if let error = error as? HTTPStatusCode {
			temperatureDescription = "Error happened with status code \(error.rawValue) (\(error.description))"
		} else {
			temperatureDescription = error.localizedDescription
		}
		
		onNeedRefresh?()
	}
}

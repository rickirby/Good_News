//
//  WeatherService.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class WeatherService: WeatherServiceProtocol {
	
	func getWeatherData(location: CLLocation) -> Observable<WeatherResResult> {
		let lat = location.coordinate.latitude.description
		let lon = location.coordinate.longitude.description
		
		let request = WeatherRequest(lat: lat, lon: lon, appid: GoodNewsConstant.openWeatherKey)
		
		let service = APIService<WeatherRequest, WeatherResResult>(req: request)
		service.baseUrl = GoodNewsConstant.openWeatherBaseUrl
		service.path = GoodNewsConstant.openWeatherPath
		
		return service.load()
	}
}

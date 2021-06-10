//
//  WeatherServiceProtocol.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

protocol WeatherServiceProtocol {
	func getWeatherData(location: CLLocation) -> Observable<WeatherResResult>
}

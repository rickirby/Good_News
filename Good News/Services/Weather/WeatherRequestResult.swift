//
//  WeatherRequestResult.swift
//  Good News
//
//  Created by Ricki Bin Yamin on 01/06/21.
//

import Foundation

struct WeatherRequest: Encodable {
	var lat: String
	var lon: String
	var appid: String
}

struct WeatherResResult: Decodable {
	let name: String
	let weather: [WeatherWeatherResObject]
	let main: WeatherMainResObject
}

struct WeatherWeatherResObject: Decodable {
	let description: String
	let icon: String
}

struct WeatherMainResObject: Decodable {
	let temp: Double
	let pressure: Int
	let humidity: Int
}

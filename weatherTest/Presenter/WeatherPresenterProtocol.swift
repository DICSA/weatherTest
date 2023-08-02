//
//  WeatherPresenterProtocol.swift
//  weatherTest
//
//  Created by Белов Руслан on 01/08/23.
//

import Foundation

protocol WeatherPresenterProtocol {
    
    var model: WeatherData? { get set }

    func fetchData(city: String)
}

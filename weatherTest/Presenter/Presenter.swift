//
//  Presenter.swift
//  weatherTest
//
//  Created by Белов Руслан on 01/08/23.
//

import Foundation

class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?

    var networkServices = NetworkServices()

    var model: WeatherData?

    func fetchData(city: String) {
        networkServices.getApi(city: city) { model in
            self.model = model
        }
            view?.setData()
    }
}

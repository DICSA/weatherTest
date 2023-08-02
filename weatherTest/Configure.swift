//
//  Configure.swift
//  weatherTest
//
//  Created by Белов Руслан on 01/08/23.
//

import Foundation
import UIKit

class WeatherViewConfigurator {
    static func config() -> UIViewController {

        let vc = ViewController()
        let presenter = WeatherPresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}

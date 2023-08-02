//
//  NetworkServices.swift
//  weatherTest
//
//  Created by Белов Руслан on 01/08/23.
//

import Foundation

class NetworkServices {

    func getApi(city: String, complitions: @escaping (WeatherData) -> Void) {

        let headers = [
            "X-RapidAPI-Key": "e8dae64e25msh6437fc18bbbb381p17875cjsnd260543a0f8b",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/forecast.json?q=\(city)&days=3")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                guard let data = data else { return }
                guard let model = self.parseJson(type: WeatherData.self, data: data) else { return }
                complitions(model)
            }
        })

        dataTask.resume()
    }
    private func parseJson<T: Codable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        return model
    }
}



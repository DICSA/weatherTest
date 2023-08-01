//
//  ViewController.swift
//  weatherTest
//
//  Created by Белов Руслан on 27/07/23.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        return label
    }()

    private let iconImage: UIImage? = {
        var iconImage = UIImage()
        iconImage = UIImage(named: "weather")!
        return iconImage
    }()

    lazy var imageView: UIImageView? = {
        guard let iconImage = iconImage else {
            return nil
        }
        let imageView = UIImageView(image: iconImage)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Get weather", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupConstraints()
    }
}

extension ViewController {
    func addSubView() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(imageView!)
        view.addSubview(button)
    }
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.centerX.equalToSuperview()
        }
        imageView!.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView!.snp.bottom).offset(60)
        }
    }
    @objc func buttonTapped() {
        //добавляем анимацию кнопке
        UIView.animate(withDuration: 0.2, animations: {
            self.button.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        }) { (completed) in
            UIView.animate(withDuration: 0.2) {
                self.button.backgroundColor = UIColor.orange.withAlphaComponent(1)
            }
        }

        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data,response,error in
            if let data, let weather = try?
                JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.label.text = "\(weather.currentWeather.temperature)"
                }
            } else {
                print("хуй")
            }
        }
        task.resume()
    }
}


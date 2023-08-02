//
//  ViewController.swift
//  weatherTest
//
//  Created by Белов Руслан on 27/07/23.
//

import UIKit
import SnapKit


final class ViewController: UIViewController, WeatherViewProtocol {

    var presenter: WeatherPresenterProtocol?

    var city = "Moscow"

    private let temperatureLabel: UILabel = {
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
        view.addSubview(temperatureLabel)
        view.addSubview(imageView!)
        view.addSubview(button)
    }
    func setupConstraints() {
        temperatureLabel.snp.makeConstraints { make in
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

    func setData() {
        guard let model = presenter?.model else { return }
        temperatureLabel.text = String(model.current.tempC)
    }

    @objc func buttonTapped() {
        presenter?.fetchData(city: city)
        //добавляем анимацию кнопке
        UIView.animate(withDuration: 0.2, animations: {
            self.button.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        }) { (completed) in
            UIView.animate(withDuration: 0.2) {
                self.button.backgroundColor = UIColor.orange.withAlphaComponent(1)
            }
        }
    }
}


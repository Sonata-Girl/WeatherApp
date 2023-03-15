//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sonata Girl on 12.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let weatherManager = WeatherManager()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView 
    }()
    
    private lazy var locationBUtton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .label
//        button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)

        return button
    }()
    
    private lazy var searchBUtton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)

        return button
    }()
    
    private lazy var searchBar: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 25)
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.backgroundColor = .systemFill
        textField.textAlignment = .right
        textField.textColor = .label
        textField.backgroundColor = .systemFill
        textField.returnKeyType = .go
        return textField
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.font = UIFont.systemFont(ofSize: 80, weight: .black)
        label.textColor = .label
//        label.textColor = .black
        label.contentMode = .left
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signTempLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
//        label.textColor = .black
        label.textColor = .label
        label.contentMode = .left
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeTempLabel: UILabel = {
        let label = UILabel()
        label.text = "C"
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
//        label.textColor = .darkGray
        label.textColor = .label
        label.contentMode = .left
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor,constant: 20)
        ])
        mainStackView.addArrangedSubview(searchStackView)
        NSLayoutConstraint.activate([
            searchStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        searchStackView.addArrangedSubview(locationBUtton)
        searchStackView.addArrangedSubview(searchBar)
        searchStackView.addArrangedSubview(searchBUtton)
        NSLayoutConstraint.activate([
            locationBUtton.widthAnchor.constraint(equalToConstant: 40),
            locationBUtton.heightAnchor.constraint(equalToConstant: 40),
            searchBUtton.widthAnchor.constraint(equalToConstant: 40),
            searchBUtton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mainStackView.addArrangedSubview(weatherImageView)
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        mainStackView.addArrangedSubview(tempStackView)
        tempStackView.addArrangedSubview(degreesLabel)
        tempStackView.addArrangedSubview(signTempLabel)
        tempStackView.addArrangedSubview(typeTempLabel)
        
        mainStackView.addArrangedSubview(cityLabel)
        mainStackView.addArrangedSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        mainStackView.addArrangedSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalToConstant: 240),
            emptyView.heightAnchor.constraint(equalToConstant: 420)
        ])
    }
    
    @objc
    private func searchButtonPressed(_ sender: UIButton) {
        searchBar.text = "go"
        searchBar.endEditing(true)
    }
}

extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchBar.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchBar.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
}

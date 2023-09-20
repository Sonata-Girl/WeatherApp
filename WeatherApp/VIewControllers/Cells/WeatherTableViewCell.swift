//
//  WeekWheatherTableViewCell.swift
//  WeatherApp
//
//  Created by Sonata Girl on 06.09.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signTempLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeTempLabel: UILabel = {
        let label = UILabel()
        label.text = "C"
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptylabel: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        let horizontalDistance: CGFloat = 10
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true

        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalDistance),
            timeLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4)
        ])
        contentView.addSubview(weatherImageView)
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: horizontalDistance),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(tempStackView)
        tempStackView.addArrangedSubview(emptylabel)
        tempStackView.addArrangedSubview(degreesLabel)
        tempStackView.addArrangedSubview(signTempLabel)
        tempStackView.addArrangedSubview(typeTempLabel)
       
        NSLayoutConstraint.activate([
            tempStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempStackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: horizontalDistance),
            tempStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalDistance),
        ])

    }
    
    func configureCell(temperatureString: String?, weatherName: String?, timeText: String) {
        degreesLabel.text = temperatureString ?? "no data"
        weatherImageView.image = UIImage(systemName: weatherName ?? "none")
        timeLabel.text = timeText
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        degreesLabel.text = nil
        weatherImageView.image = nil
        timeLabel.text = nil
    }
}



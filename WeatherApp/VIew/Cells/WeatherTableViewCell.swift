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
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = .label
        label.contentMode = .left
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signTempLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        label.textColor = .label
        label.contentMode = .left
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeTempLabel: UILabel = {
        let label = UILabel()
        label.text = "C"
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
        label.textColor = .label
        label.contentMode = .left
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        let verticalConstant: CGFloat = 12
        let horizontalConstant: CGFloat = 24
        let horizontalDistance: CGFloat = 16
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
//
//        contentView.addSubview(receptImageView)
//        NSLayoutConstraint.activate([
//            receptImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            receptImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: verticalConstant),
//            receptImageView.heightAnchor.constraint(equalToConstant: 40),
//            receptImageView.widthAnchor.constraint(equalToConstant: 40)
//        ])
//
//        contentView.addSubview(labelReceptName)
//        NSLayoutConstraint.activate([
//            labelReceptName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            labelReceptName.leadingAnchor.constraint(equalTo: receptImageView.trailingAnchor, constant: horizontalDistance)
//        ])
//        contentView.addSubview(labelReceptWeight)
//        NSLayoutConstraint.activate([
//            labelReceptWeight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            labelReceptWeight.leadingAnchor.constraint(equalTo: labelReceptName.trailingAnchor, constant: horizontalDistance),
//            contentView.trailingAnchor.constraint(equalTo: labelReceptWeight.trailingAnchor, constant: horizontalConstant),
//            contentView.bottomAnchor.constraint(equalTo: labelReceptWeight.bottomAnchor, constant: verticalConstant)
//        ])
    }
    
     func configure(receptName: String, imageRecept: UIImage?) {
//
//        let imageRecept = imageRecept ?? UIImage(named: "ImageFirst")
//
//        labelReceptName.text = receptName
//        receptImageView.image = imageRecept
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        labelReceptName.text = nil
//        receptImageView.image = nil
    }
}



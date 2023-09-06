//
//  weatherWeekView.swift
//  WeatherApp
//
//  Created by Sonata Girl on 06.09.2023.
//

import UIKit

enum TableViewSourceType {
    case week, threeDays
}

final class WeatherWeekView: UIView {
    
    var tableSourceType: TableViewSourceType = .threeDays
    var weekWeatherList: [WeatherModel]?
    var threeDayWeatherList: [WeatherModel]?
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        tableView.layer.cornerRadius = 30
        tableView.layer.borderWidth = 2.0
        tableView.layer.masksToBounds = true
        return tableView
    }()
    
  
    
    init() {
        super.init(frame: .zero)

        tableView.dataSource = self
        tableView.delegate = self
        
        setupUI()
    }
    
    func configureView(tableSourceType: TableViewSourceType = .threeDays,
                       weekWeatherList: [WeatherModel],
                       threeDayWeatherList: [WeatherModel]) {
        self.tableSourceType = tableSourceType
        self.weekWeatherList = weekWeatherList
        self.threeDayWeatherList = threeDayWeatherList
        
        loadTableSource(typeOfTableView: tableSourceType)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
//        layer.cornerRadius = 30
        clipsToBounds = true
        
        addSubview(tableView)
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

    func loadTableSource(typeOfTableView: TableViewSourceType) {
        tableSourceType = typeOfTableView

        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)

    }

    func reloadSourceTable(typeOfTableView: TableViewSourceType) {
        loadTableSource(typeOfTableView: typeOfTableView)
        tableView.reloadData()
    }
}

extension WeatherWeekView: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableSourceType {
        case .week:
            return weekWeatherList?.count ?? 0
        case .threeDays:
            return threeDayWeatherList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return switchTableViewCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableSourceType {
        case .week:
            return tableView.frame.size.height / 7
        case .threeDays:
            return tableView.frame.size.height / 3
        }
    }
    
    private func switchTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell()}
        
        cell.configure(receptName: "receptName + \(indexPath.row+1)", imageRecept: UIImage(named: "imageFirst"))
        
        return cell
        
    }
}

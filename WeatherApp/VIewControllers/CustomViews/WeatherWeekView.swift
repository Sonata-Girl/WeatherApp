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
    
    private var tableSourceType: TableViewSourceType = .threeDays
    private var weekWeatherList: WeatherModels?
    private var threeDayWeatherList: WeatherModels?
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.borderColor = UIColor.blue.withAlphaComponent(0.1).cgColor
        tableView.layer.cornerRadius = 30
        tableView.layer.borderWidth = 2
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        setupGestures()
        setupUI()
    }
    
    func configureView(tableSourceType: TableViewSourceType = .threeDays,
                       weekWeatherList: WeatherModels,
                       threeDayWeatherList: WeatherModels) {
        self.tableSourceType = tableSourceType
        self.weekWeatherList = weekWeatherList
        self.threeDayWeatherList = threeDayWeatherList
        
        loadTableSource(tableSourceType)
        tableView.reloadData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 30
        clipsToBounds = true
        backgroundColor = .white.withAlphaComponent(0.3)
        
        addSubview(tableView)    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

    private func setupGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(tableViewLeftSwipe))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(tableViewRightSwipe))
        rightSwipe.direction = .right
        tableView.addGestureRecognizer(leftSwipe)
        tableView.addGestureRecognizer(rightSwipe)
    }
    
    private func loadTableSource(_ typeOfTableView: TableViewSourceType?) {
        if typeOfTableView == nil {
            tableSourceType = tableSourceType == .threeDays ? .week : .threeDays
        } else {
            tableSourceType = typeOfTableView ?? .threeDays
        }
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }

    func reloadSourceTable(_ typeOfTableView: TableViewSourceType?) {
        loadTableSource(typeOfTableView)
        tableView.reloadData()
    }
    
    @objc private func tableViewLeftSwipe() {
        reloadSourceTable(nil)
    }

    @objc private func tableViewRightSwipe() {
        reloadSourceTable(nil)
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.7209929824, green: 0.8699142337, blue: 0.8820225596, alpha: 1).withAlphaComponent(0.5)
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableSourceType {
        case .week:
            return "Week"
        case .threeDays:
            return "Three days"
        }
    }
    
    
    private func switchTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,
                                                       for: indexPath) as? WeatherTableViewCell else { return UITableViewCell()}
        
        let weatherItem = weekWeatherList?[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.configureCell(temperatureString: weatherItem?.temperatureString,
                           weatherName: weatherItem?.conditionName,
                           timeText: "\(String(weatherItem?.dayNumber ?? 0)) \(weatherItem?.monthString ?? "")")
        
        return cell
        
    }
}

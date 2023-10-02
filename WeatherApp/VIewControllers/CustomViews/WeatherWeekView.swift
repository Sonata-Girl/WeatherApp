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

protocol WeatherWeekUpdater {
    func weatherDidSwitch()
}

final class WeatherWeekView: UIView {
    
    private var tableSourceType: TableViewSourceType = .threeDays
    private var weekWeatherList: WeatherModels?
    private var threeDayWeatherList: WeatherModels?
    private var pageNumber = 0
    
    var delegate: WeatherWeekUpdater?
   
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    private lazy var tableViewThreeDays: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 30
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
       
        return tableView
    }()
    
    private lazy var tableViewWeek: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 30
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
       
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    func configureView(weekWeatherList: WeatherModels,
                       threeDayWeatherList: WeatherModels) {
        self.weekWeatherList = weekWeatherList
        self.threeDayWeatherList = threeDayWeatherList
        
        tableViewThreeDays.reloadData()
        tableViewWeek.reloadData()
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
                 
        scrollView.addSubview(tableViewThreeDays)
        scrollView.addSubview(tableViewWeek)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            tableViewThreeDays.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableViewThreeDays.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableViewThreeDays.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableViewThreeDays.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            tableViewWeek.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableViewWeek.leadingAnchor.constraint(equalTo: tableViewThreeDays.trailingAnchor),
            tableViewWeek.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableViewWeek.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            tableViewWeek.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
    }

    func reloadSourceTable(_ typeOfTableView: TableViewSourceType?) {
        tableSourceType = typeOfTableView ?? .threeDays
        if typeOfTableView == .threeDays {
            pageNumber -= 1
            tableViewThreeDays.reloadData()
        } else {
            pageNumber += 1
            tableViewWeek.reloadData()
        }
        
        //  тут номер страницы умножается на ширину скрола, так передвигаем страницы на + 1 или - 1
        let xOffset = CGFloat(pageNumber) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}

extension WeatherWeekView: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewThreeDays {
            return threeDayWeatherList?.count ?? 0
        } else {
           return weekWeatherList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.7209929824, green: 0.8699142337, blue: 0.8820225596, alpha: 1).withAlphaComponent(0.1)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,
                                                       for: indexPath) as? WeatherTableViewCell else { return UITableViewCell()}
      
        var weatherItem: WeatherModel?
        
        if tableView == tableViewThreeDays {
            weatherItem = threeDayWeatherList?[indexPath.row]
        } else {
            weatherItem = weekWeatherList?[indexPath.row]
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.configureCell(temperatureString: weatherItem?.temperatureString,
                           weatherName: weatherItem?.conditionName,
                           timeText: "\(String(weatherItem?.dayNumber ?? 0)) \(weatherItem?.monthString ?? "")")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewThreeDays {
            return tableView.frame.size.height / 3
        } else {
            return tableView.frame.size.height / 7
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableViewThreeDays {
            return "Three days"
        } else {
            return "Week"
        }
    }
}

extension WeatherWeekView: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // тут вычисляем номер страницы поделив отступ по х у скрола (он будет либо 0 либо + своя ширина для каждой таблицы в скроле)
        let newPageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        print("Page Number: \(pageNumber)")
        
        if newPageNumber != pageNumber {
            tableSourceType = tableSourceType == .threeDays ? .week : .threeDays
            pageNumber = newPageNumber
            print("Page Number: \(pageNumber)")
            print("Page Number: \(tableSourceType)")
           
            delegate?.weatherDidSwitch()
        }
    }
}

//
//  TestViewController.swift
//  WeatherApp
//
//  Created by Sonata Girl on 20.09.2023.
//

import UIKit

class TestViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    let tableView1: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let tableView2: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        scrollView.delegate = self

        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")

        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")

        scrollView.addSubview(tableView1)
        scrollView.addSubview(tableView2)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView1.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableView1.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableView1.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            tableView2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableView2.leadingAnchor.constraint(equalTo: tableView1.trailingAnchor),
            tableView2.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableView2.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            tableView2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = "Table 1 - Row \(indexPath.row)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = "Table 2 - Row \(indexPath.row)"
            return cell
        }
    }
}

extension TestViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        print("Page Number: \(pageNumber)")
    }
}

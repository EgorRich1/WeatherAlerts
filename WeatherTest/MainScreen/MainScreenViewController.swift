//
//  MainScreenViewController.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import UIKit

// MARK: - MainScreenViewProtocol

protocol MainScreenViewProtocol: AnyObject {
    func dataDidLoad()
    func showError(with message: String)
}

// MARK: - MainScreenViewController

final class MainScreenViewController: UIViewController {
    
    // MARK: - Subview properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Actual alerts"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: "AlertTableViewCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Dependency
    
    private let presenter: MainScreenPresenterProtocol
    
    // MARK: - Lyfecycle
    
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.loadData()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel, activate: [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        view.addSubview(separatorView, activate: [
            separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        view.addSubview(tableView, activate: [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - Extensions

extension MainScreenViewController: MainScreenViewProtocol {
    func dataDidLoad() {
        tableView.reloadData()
    }
    
    func showError(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension MainScreenViewController: UITableViewDelegate {}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfAlerts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell", for: indexPath) as? AlertTableViewCell,
            let properties = presenter.alertData(for: indexPath)
        else {
            return UITableViewCell()
        }
        cell.configure(
            event: properties.event,
            sender: properties.senderName,
            duration: properties.duration,
            cellIndex: indexPath.row
        )
        return cell
    }
}

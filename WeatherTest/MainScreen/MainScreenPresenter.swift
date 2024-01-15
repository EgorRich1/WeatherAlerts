//
//  MainScreenPresenter.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import Foundation

// MARK: - MainScreenPresenterProtocol

protocol MainScreenPresenterProtocol {
    var numberOfAlerts: Int { get }
    func loadData()
    func alertData(for indexPath: IndexPath) -> WeatherAlert.WeatherFeature.Property?
}

// MARK: - MainScreenPresenter

final class MainScreenPresenter {
    
    // MARK: - Private properties
    
    private let apiManager: ApiManager
    private var weatherAlert: WeatherAlert?
    private (set) var numberOfAlerts: Int = .zero
    
    // MARK: - Dependency
    
    weak var viewController: MainScreenViewProtocol?
    
    // MARK: - Init
    
    init(apiManager: ApiManager = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

// MARK: - Extensions

extension MainScreenPresenter: MainScreenPresenterProtocol{
    func loadData() {
        apiManager.loadWeatherAlerts { [weak self] result in
            switch result {
            case let .success(weatherAlert):
                self?.weatherAlert = weatherAlert
                self?.numberOfAlerts = weatherAlert.features.count
                DispatchQueue.main.async {
                    self?.viewController?.dataDidLoad()
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.viewController?.showError(with: error.localizedDescription)
                }
            }
        }
    }
    
    func alertData(for indexPath: IndexPath) -> WeatherAlert.WeatherFeature.Property? {
        return weatherAlert?.features[indexPath.row].properties
    }
}

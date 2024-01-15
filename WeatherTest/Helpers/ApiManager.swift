//
//  ApiManager.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import Foundation

final class ApiManager {
    
    static let shared = ApiManager()
    
    // MARK: - Private methods
    
    private func send(
        method: String = "GET",
        path: String,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        guard let url = URL(string: path) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    // MARK: - Public methods
    
    func loadImage(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: "https://picsum.photos/1000") else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func loadWeatherAlerts(completion: @escaping (Result<WeatherAlert, Error>) -> Void) {
        send(path: "https://api.weather.gov/alerts/active?status=actual&message_type=alert") { data, _, error in
            guard let data = data else {
                let errorDesc = error?.localizedDescription ?? "Unknown error"
                completion(.failure(NSError(domain: errorDesc, code: -1, userInfo: nil)))
                return
            }
            do {
                let result = try JSONDecoder().decode(WeatherAlert.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(NSError(domain: error.localizedDescription, code: -1, userInfo: nil)))
            }
        }
    }
}

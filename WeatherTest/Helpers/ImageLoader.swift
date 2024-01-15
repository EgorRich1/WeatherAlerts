//
//  ImageLoader.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import Foundation
//import UIKit

// MARK: - ImageLoader

final class ImageLoader {
    
    // MARK: - Public properties
    
    static let shared = ImageLoader()
    
    // MARK: - Private properties
    
    private let apiManager: ApiManager
    private var loadedData = [Int: Data]()
    private var loadedFileNames = [String]()
    
    // MARK: - Init
    
    init(apiManager: ApiManager = .shared) {
        self.apiManager = apiManager
    }
    
    // MARK: - Public methods
    
    func loadImage(for row: Int, completion: @escaping (Data) -> Void) {
        if let data = loadedData[row] {
            completion(data)
            return
        }
        apiManager.loadImage { [weak self] data, response, error in
            guard let self = self,
                let data = data,
                let fileName = response?.suggestedFilename
            else { return }
            if !self.loadedFileNames.contains(where: {$0 == fileName}){
                self.loadedData[row] = data
                self.loadedFileNames.append(fileName)
                completion(data)
            } else {
                loadImage(for: row, completion: completion)
            }
        }
    }
}

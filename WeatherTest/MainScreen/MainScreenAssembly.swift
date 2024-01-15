//
//  MainScreenAssembly.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import UIKit

// MARK: - MainScreenAssembly

final class MainScreenAssembly {
    
    class func assembly() -> UIViewController {
        let presenter = MainScreenPresenter()
        let viewController = MainScreenViewController(presenter: presenter)
        
        presenter.viewController = viewController
        
        return viewController
    }
}

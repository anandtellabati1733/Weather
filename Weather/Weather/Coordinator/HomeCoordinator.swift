//
//  HomeCoordinator.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let apiManager = NetworkManager()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = WeatherViewController()
        let weatherViewModel = WeatherViewModel(apiManager: self.apiManager)
        weatherViewModel.coordinator = self
        vc.viewModel = weatherViewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func loadCitySearchVC(completion: @escaping (String) -> Void, errorHandler:@escaping (String) -> ()) {
        let viewmodel = LocationSearchViewModel()
        let searchMapVC =  UIHostingController(rootView: LocationSearchView(searchModel: viewmodel))
        viewmodel.completionHandler  = {[weak self] result in
            completion(result)
            self?.navigationController.dismiss(animated: true)
        }
        self.navigationController.present(searchMapVC, animated: true)
    }
    
}

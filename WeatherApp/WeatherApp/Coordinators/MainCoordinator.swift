import Foundation
import UIKit
import SwiftUI
class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let apiManager = NetworkManager()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = WeatherInfoViewController.instantiate()
        let converterViewModel = WeatherInfoViewModel(apiManager: self.apiManager)
        vc.viewModel = converterViewModel
        vc.coordinator = self
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

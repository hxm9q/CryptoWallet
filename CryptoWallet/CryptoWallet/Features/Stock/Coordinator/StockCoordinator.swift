import UIKit

class StockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showStock()
    }
    
    func showStock(title: String = "Stocks") {
        let viewController = builder.buildStockViewController(title: title)
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showStockDetail(stock: Stock) {
        let viewController = builder.buildStockDetailViewController(stock: stock)
        viewController.viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromStockDetail() {
        navigationController.popViewController(animated: true)
    }
}

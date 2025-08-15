import UIKit

class StockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let factory: StockFactoryProtocol
    
    init(navigationController: UINavigationController, factory: StockFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewModel = factory.makeStockViewModel(title: "Stocks")
        viewModel.coordinator = self
        
        let viewController = factory.makeStockViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showStockDetail(stock: Stock) {
        let viewModel = factory.makeStockDetailViewModel(stock: stock)
        viewModel.coordinator = self
        
        let viewController = factory.makeStockDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromStockDetail() {
        navigationController.popViewController(animated: true)
    }
}

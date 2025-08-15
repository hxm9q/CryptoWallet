import UIKit

protocol StockFactoryProtocol {
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator
    
    func makeStockViewController(viewModel: StockViewModel) -> StockViewController
    func makeStockViewModel(title: String) -> StockViewModel
    
    func makeStockDetailViewController(viewModel: StockDetailViewModel) -> StockDetailViewController
    func makeStockDetailViewModel(stock: Stock) -> StockDetailViewModel
}

class StockFactory: StockFactoryProtocol {
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator {
        return StockCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeStockViewController(viewModel: StockViewModel) -> StockViewController {
        return StockViewController(viewModel: viewModel)
    }
    
    func makeStockViewModel(title: String) -> StockViewModel {
        return StockViewModel(title: title)
    }
    
    func makeStockDetailViewController(viewModel: StockDetailViewModel) -> StockDetailViewController {
        return StockDetailViewController(viewModel: viewModel)
    }
    
    func makeStockDetailViewModel(stock: Stock) -> StockDetailViewModel {
        return StockDetailViewModel(stock: stock)
    }
}

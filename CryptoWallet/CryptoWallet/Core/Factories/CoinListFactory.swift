import UIKit

protocol CoinListFactoryProtocol {
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func makeCoinListViewController(viewModel: CoinListViewModel) -> CoinListViewController
    func makeCoinListViewModel() -> CoinListViewModel
}

class CoinListFactory: CoinListFactoryProtocol {
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator {
        return CoinListCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeCoinListViewController(viewModel: CoinListViewModel) -> CoinListViewController {
        return CoinListViewController(coinListViewModel: viewModel)
    }
    
    func makeCoinListViewModel() -> CoinListViewModel {
        return CoinListViewModel()
    }
}

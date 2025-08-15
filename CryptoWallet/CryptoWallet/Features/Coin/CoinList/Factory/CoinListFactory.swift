import UIKit

protocol CoinListFactoryProtocol {
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func makeCoinListViewController(viewModel: CoinListViewModel) -> CoinListViewController
    func makeCoinListViewModel() -> CoinListViewModel
    func makeCoinDetailCoordinator(navigationController: UINavigationController, coin: Coin) -> CoinDetailCoordinator
}

class CoinListFactory: CoinListFactoryProtocol {
    private lazy var coinDetailFactory: CoinDetailFactoryProtocol = CoinDetailFactory()
    
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator {
        return CoinListCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeCoinListViewController(viewModel: CoinListViewModel) -> CoinListViewController {
        return CoinListViewController(coinListViewModel: viewModel)
    }
    
    func makeCoinListViewModel() -> CoinListViewModel {
        return CoinListViewModel()
    }
    
    func makeCoinDetailCoordinator(navigationController: UINavigationController, coin: Coin) -> CoinDetailCoordinator {
        return coinDetailFactory.makeCoinDetailCoordinator(navigationController: navigationController, coin: coin)
    }
}

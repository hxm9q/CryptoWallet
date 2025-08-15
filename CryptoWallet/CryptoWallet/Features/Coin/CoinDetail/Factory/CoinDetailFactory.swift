import UIKit

protocol CoinDetailFactoryProtocol {
    func makeCoinDetailCoordinator(navigationController: UINavigationController, coin: Coin) -> CoinDetailCoordinator
    func makeCoinDetailViewController(viewModel: CoinDetailViewModel) -> CoinDetailViewController
    func makeCoinDetailViewModel(coin: Coin) -> CoinDetailViewModel
}

class CoinDetailFactory: CoinDetailFactoryProtocol {
    func makeCoinDetailCoordinator(navigationController: UINavigationController, coin: Coin) -> CoinDetailCoordinator {
        return CoinDetailCoordinator(navigationController: navigationController, factory: self, coin: coin)
    }
    
    func makeCoinDetailViewController(viewModel: CoinDetailViewModel) -> CoinDetailViewController {
        return CoinDetailViewController(viewModel: viewModel)
    }
    
    func makeCoinDetailViewModel(coin: Coin) -> CoinDetailViewModel {
        return CoinDetailViewModel(coin: coin)
    }
}

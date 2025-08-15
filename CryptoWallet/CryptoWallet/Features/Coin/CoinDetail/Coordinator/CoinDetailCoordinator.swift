import UIKit

class CoinDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let factory: CoinDetailFactoryProtocol
    private let coin: Coin
    
    init(navigationController: UINavigationController, factory: CoinDetailFactoryProtocol, coin: Coin) {
        self.navigationController = navigationController
        self.factory = factory
        self.coin = coin
    }
    
    func start() {
        let viewModel = factory.makeCoinDetailViewModel(coin: coin)
        viewModel.coordinator = self
        
        let viewController = factory.makeCoinDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromCoinDetail() {
        navigationController.popViewController(animated: true)
    }
}

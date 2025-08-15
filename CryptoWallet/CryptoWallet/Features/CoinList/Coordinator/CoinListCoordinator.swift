import UIKit

protocol CoinListCoordinatorDelegate: AnyObject {
    func coinListDidRequestLogout()
}

class CoinListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: CoinListCoordinatorDelegate?
    private let factory: CoinListFactoryProtocol
    
    init(navigationController: UINavigationController, factory: CoinListFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewModel = factory.makeCoinListViewModel()
        viewModel.coordinator = self
        
        let viewController = factory.makeCoinListViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func logout() {
        delegate?.coinListDidRequestLogout()
    }
    
    func showCoinDetail(coin: Coin) {
        let coinDetailCoordinator = factory.makeCoinDetailCoordinator(navigationController: navigationController, coin: coin)
        addChild(coinDetailCoordinator)
        coinDetailCoordinator.start()
    }
}

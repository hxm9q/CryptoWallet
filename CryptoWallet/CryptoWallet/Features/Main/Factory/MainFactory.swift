import UIKit

protocol MainFactoryProtocol {
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator
    func makeMainTabBarController() -> MainTabBarController
    
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator
    func makeWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator
}

class MainFactory: MainFactoryProtocol {
    private lazy var coinListFactory: CoinListFactoryProtocol = CoinListFactory()
    private lazy var stockFactory: StockFactoryProtocol = StockFactory()
    private lazy var walletFactory: WalletFactoryProtocol = WalletFactory()
    
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController()
    }
    
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator {
        coinListFactory.makeCoinListCoordinator(navigationController: navigationController)
    }
    
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator {
        stockFactory.makeStockCoordinator(navigationController: navigationController)
    }
    
    func makeWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator {
        walletFactory.makeWalletCoordinator(navigationController: navigationController)
    }
}

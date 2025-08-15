import UIKit

protocol MainFactoryProtocol {
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator
    func makeMainTabBarController() -> MainTabBarController
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator
}

class MainFactory: MainFactoryProtocol {
    private lazy var coinListFactory: CoinListFactoryProtocol = CoinListFactory()
    private lazy var stockFactory: StockFactoryProtocol = StockFactory()
    
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
}

import UIKit

protocol MainFactoryProtocol {
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator
    func makeMainTabBarController() -> MainTabBarController
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
}

class MainFactory: MainFactoryProtocol {
    private lazy var coinListFactory: CoinListFactoryProtocol = CoinListFactory()
    
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController()
    }
    
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator {
        coinListFactory.makeCoinListCoordinator(navigationController: navigationController)
    }
}

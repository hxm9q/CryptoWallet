import UIKit

protocol MainFactoryProtocol {
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator
    func makeMainTabBarController() -> MainTabBarController
    
    func makeCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func makeStockCoordinator(navigationController: UINavigationController) -> StockCoordinator
    func makeWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator
    func makeArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator
}

class MainFactory: MainFactoryProtocol {
    private lazy var coinListFactory: CoinListFactoryProtocol = CoinListFactory()
    private lazy var stockFactory: StockFactoryProtocol = StockFactory()
    private lazy var walletFactory: WalletFactoryProtocol = WalletFactory()
    private lazy var articleFactory: ArticleFactoryProtocol = ArticleFactory()
    private lazy var profileFactory: ProfileFactoryProtocol = ProfileFactory()
    
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
    
    func makeArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator {
        articleFactory.makeArticleCoordinator(navigationController: navigationController)
    }
    
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator {
        profileFactory.makeProfileCoordinator(navigationController: navigationController)
    }
}

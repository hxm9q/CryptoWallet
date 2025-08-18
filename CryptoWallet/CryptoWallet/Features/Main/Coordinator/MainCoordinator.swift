import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func makeDidRequestLogout()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: MainCoordinatorDelegate?
    private let factory: MainFactoryProtocol
    private var tabBarController: MainTabBarController?
    
    init(navigationController: UINavigationController, factory: MainFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let tabBarController = factory.makeMainTabBarController()
        setupTabBarCoordinators(tabBarController: tabBarController)
        
        self.tabBarController = tabBarController
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func setupTabBarCoordinators(tabBarController: MainTabBarController) {
        // Coin List
        let coinListNav = UINavigationController()
        let coinListCoordinator = factory.makeCoinListCoordinator(navigationController: coinListNav)
        coinListCoordinator.delegate = self
        addChild(coinListCoordinator)
        coinListCoordinator.start()
        
        // Stocks
        let stocksNav = UINavigationController()
        let stocksCoordinator = factory.makeStockCoordinator(navigationController: stocksNav)
        addChild(stocksCoordinator)
        stocksCoordinator.start()
        
        // Wallet
        let walletNav = UINavigationController()
        let walletCoordinator = factory.makeWalletCoordinator(navigationController: walletNav)
        addChild(walletCoordinator)
        walletCoordinator.start()
        
        // Articles
        let articleNav = UINavigationController()
        let articleCoordinator = factory.makeArticleCoordinator(navigationController: articleNav)
        addChild(articleCoordinator)
        articleCoordinator.start()
        
        // Profile
        let profileNav = UINavigationController()
        let profileCoordinator = factory.makeProfileCoordinator(navigationController: profileNav)
        addChild(profileCoordinator)
        profileCoordinator.start()
        
        coinListNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_tab"), tag: 0)
        stocksNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stocks_tab"), tag: 1)
        walletNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "wallet_tab"), tag: 2)
        articleNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "book_tab"), tag: 3)
        profileNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "person_tab"), tag: 4)
        
        tabBarController.viewControllers = [
            coinListNav,
            stocksNav,
            walletNav,
            articleNav,
            profileNav
        ]
    }
}

extension MainCoordinator: CoinListCoordinatorDelegate {
    func coinListDidRequestLogout() {
        delegate?.makeDidRequestLogout()
    }
}

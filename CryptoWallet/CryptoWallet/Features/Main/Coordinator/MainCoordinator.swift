import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func makeDidRequestLogout()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: MainCoordinatorDelegate?
    private let builder: ViewControllerBuilderProtocol
    var tabBarController: MainTabBarController?
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let tabBarController = builder.buildMainTabBarController()
        setupTabBarCoordinators(tabBarController: tabBarController)
        self.tabBarController = tabBarController
    }
    
    private func setupTabBarCoordinators(tabBarController: MainTabBarController) {
        // Coin List
        let coinListNav = UINavigationController()
        let coinListCoordinator = builder.buildCoinListCoordinator(navigationController: coinListNav)
        coinListCoordinator.delegate = self
        addChild(coinListCoordinator)
        coinListCoordinator.start()
        
        // Stocks
        let stocksNav = UINavigationController()
        let stocksCoordinator = builder.buildStockCoordinator(navigationController: stocksNav)
        addChild(stocksCoordinator)
        stocksCoordinator.start()
        
        // Wallet
        let walletNav = UINavigationController()
        let walletCoordinator = builder.buildWalletCoordinator(navigationController: walletNav)
        addChild(walletCoordinator)
        walletCoordinator.start()
        
        // Articles
        let articleNav = UINavigationController()
        let articleCoordinator = builder.buildArticleCoordinator(navigationController: articleNav)
        addChild(articleCoordinator)
        articleCoordinator.start()
        
        // Profile
        let profileNav = UINavigationController()
        let profileCoordinator = builder.buildProfileCoordinator(navigationController: profileNav)
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

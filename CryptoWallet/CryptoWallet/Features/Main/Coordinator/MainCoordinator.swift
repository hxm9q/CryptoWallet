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
        let coinListNav = UINavigationController()
        let coinListCoordinator = factory.makeCoinListCoordinator(navigationController: coinListNav)
        
        coinListCoordinator.delegate = self
        
        addChild(coinListCoordinator)
        coinListCoordinator.start()
        
        let stocksNav = UINavigationController()
        let stocksCoordinator = factory.makeStockCoordinator(navigationController: stocksNav)
        
        addChild(stocksCoordinator)
        stocksCoordinator.start()
        
        let walletNav = UINavigationController()
        let walletVC = UIViewController()
        walletVC.view.backgroundColor = .systemGray6
        walletNav.setViewControllers([walletVC], animated: false)
        
        let bookNav = UINavigationController()
        let bookVC = UIViewController()
        bookVC.view.backgroundColor = .systemGray6
        bookNav.setViewControllers([bookVC], animated: false)
        
        let personNav = UINavigationController()
        let personVC = UIViewController()
        personVC.view.backgroundColor = .systemGray6
        personNav.setViewControllers([personVC], animated: false)
        
        coinListNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_tab"), tag: 0)
        stocksNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stocks_tab"), tag: 1)
        walletNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "wallet_tab"), tag: 2)
        bookNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "book_tab"), tag: 3)
        personNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "person_tab"), tag: 4)
        
        tabBarController.viewControllers = [
            coinListNav,
            stocksNav,
            walletNav,
            bookNav,
            personNav
        ]
    }
}

extension MainCoordinator: CoinListCoordinatorDelegate {
    func coinListDidRequestLogout() {
        delegate?.makeDidRequestLogout()
    }
}

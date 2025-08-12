import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    private func setupTabs() {
        let coinListVC = CoinListViewController()
        coinListVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_tab"), tag: 0)
        
        let stocksVC = UIViewController()
        stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stocks_tab"), tag: 1)
        
        let walletVC = UIViewController()
        walletVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "wallet_tab"), tag: 2)
        
        let bookVC = UIViewController()
        bookVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "book_tab"), tag: 3)
        
        let personVC = UIViewController()
        personVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "person_tab"), tag: 4)
        
        viewControllers = [
            UINavigationController(rootViewController: coinListVC),
            UINavigationController(rootViewController: stocksVC),
            UINavigationController(rootViewController: walletVC),
            UINavigationController(rootViewController: bookVC),
            UINavigationController(rootViewController: personVC)
        ]
    }
}

#Preview {
    MainTabBarController()
}

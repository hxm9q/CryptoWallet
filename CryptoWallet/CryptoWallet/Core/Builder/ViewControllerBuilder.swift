import UIKit

protocol ViewControllerBuilderProtocol {
    // MARK: - Article Feature
    func buildArticleViewController(title: String) -> ArticleViewController
    func buildArticleDetailViewController(article: Article) -> ArticleDetailViewController
    
    // MARK: - Auth Feature
    func buildAuthViewController() -> AuthViewController
    
    // MARK: - Coin Feature
    func buildCoinListViewController() -> CoinListViewController
    func buildCoinDetailViewController(coin: Coin) -> CoinDetailViewController
    
    // MARK: - Profile Feature
    func buildProfileViewController(title: String) -> ProfileViewController
    func buildProfileDetailViewController(profile: Profile) -> ProfileDetailViewController
    
    // MARK: - Stock Feature
    func buildStockViewController(title: String) -> StockViewController
    func buildStockDetailViewController(stock: Stock) -> StockDetailViewController
    
    // MARK: - Wallet Feature
    func buildWalletViewController(title: String) -> WalletViewController
    func buildWalletDetailViewController(wallet: Wallet) -> WalletDetailViewController
    
    // MARK: - Main Feature
    func buildMainTabBarController() -> MainTabBarController
    
    // MARK: - Coordinators
    func buildCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator
    func buildStockCoordinator(navigationController: UINavigationController) -> StockCoordinator
    func buildWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator
    func buildArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator
    func buildProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator
    func buildAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator
    func buildMainCoordinator(navigationController: UINavigationController) -> MainCoordinator
}

class ViewControllerBuilder: ViewControllerBuilderProtocol {
    // MARK: - Article Feature
    func buildArticleViewController(title: String) -> ArticleViewController {
        let viewModel = ArticleViewModel(title: title)
        return ArticleViewController(viewModel: viewModel)
    }
    
    func buildArticleDetailViewController(article: Article) -> ArticleDetailViewController {
        let viewModel = ArticleDetailViewModel(article: article)
        return ArticleDetailViewController(viewModel: viewModel)
    }
    
    // MARK: - Auth Feature
    func buildAuthViewController() -> AuthViewController {
        let viewModel = AuthViewModel()
        return AuthViewController(viewModel: viewModel)
    }
    
    // MARK: - Coin Feature
    func buildCoinListViewController() -> CoinListViewController {
        let viewModel = CoinListViewModel()
        return CoinListViewController(viewModel: viewModel)
    }
    
    func buildCoinDetailViewController(coin: Coin) -> CoinDetailViewController {
        let viewModel = CoinDetailViewModel(coin: coin)
        return CoinDetailViewController(viewModel: viewModel)
    }
    
    // MARK: - Profile Feature
    func buildProfileViewController(title: String) -> ProfileViewController {
        let viewModel = ProfileViewModel(title: title)
        return ProfileViewController(viewModel: viewModel)
    }
    
    func buildProfileDetailViewController(profile: Profile) -> ProfileDetailViewController {
        let viewModel = ProfileDetailViewModel(profile: profile)
        return ProfileDetailViewController(viewModel: viewModel)
    }
    
    // MARK: - Stock Feature
    func buildStockViewController(title: String) -> StockViewController {
        let viewModel = StockViewModel(title: title)
        return StockViewController(viewModel: viewModel)
    }
    
    func buildStockDetailViewController(stock: Stock) -> StockDetailViewController {
        let viewModel = StockDetailViewModel(stock: stock)
        return StockDetailViewController(viewModel: viewModel)
    }
    
    // MARK: - Wallet Feature
    func buildWalletViewController(title: String) -> WalletViewController {
        let viewModel = WalletViewModel(title: title)
        return WalletViewController(viewModel: viewModel)
    }
    
    func buildWalletDetailViewController(wallet: Wallet) -> WalletDetailViewController {
        let viewModel = WalletDetailViewModel(wallet: wallet)
        return WalletDetailViewController(viewModel: viewModel)
    }
    
    // MARK: - Main Feature
    func buildMainTabBarController() -> MainTabBarController {
        return MainTabBarController()
    }
    
    // MARK: - Coordinators
    func buildArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator {
        return ArticleCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildCoinListCoordinator(navigationController: UINavigationController) -> CoinListCoordinator {
        return CoinListCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator {
        return ProfileCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildStockCoordinator(navigationController: UINavigationController) -> StockCoordinator {
        return StockCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator {
        return WalletCoordinator(navigationController: navigationController, builder: self)
    }
    
    func buildMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController, builder: self)
    }
}

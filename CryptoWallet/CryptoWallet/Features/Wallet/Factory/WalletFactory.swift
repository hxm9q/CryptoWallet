import UIKit

protocol WalletFactoryProtocol {
    func makeWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator
    
    func makeWalletViewController(viewModel: WalletViewModel) -> WalletViewController
    func makeWalletViewModel(title: String) -> WalletViewModel
    
    func makeWalletDetailViewController(viewModel: WalletDetailViewModel) -> WalletDetailViewController
    func makeWalletDetailViewModel(wallet: Wallet) -> WalletDetailViewModel
}

class WalletFactory: WalletFactoryProtocol {
    func makeWalletCoordinator(navigationController: UINavigationController) -> WalletCoordinator {
        return WalletCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeWalletViewController(viewModel: WalletViewModel) -> WalletViewController {
        return WalletViewController(viewModel: viewModel)
    }
    
    func makeWalletViewModel(title: String) -> WalletViewModel {
        return WalletViewModel(title: title)
    }
    
    func makeWalletDetailViewController(viewModel: WalletDetailViewModel) -> WalletDetailViewController {
        return WalletDetailViewController(viewModel: viewModel)
    }
    
    func makeWalletDetailViewModel(wallet: Wallet) -> WalletDetailViewModel {
        return WalletDetailViewModel(wallet: wallet)
    }
}

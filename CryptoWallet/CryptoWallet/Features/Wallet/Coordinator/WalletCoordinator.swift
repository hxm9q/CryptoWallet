import UIKit

class WalletCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let factory: WalletFactoryProtocol
    
    init(navigationController: UINavigationController, factory: WalletFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewModel = factory.makeWalletViewModel(title: "Wallet")
        viewModel.coordinator = self
        
        let viewController = factory.makeWalletViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showWalletDetail(wallet: Wallet) {
        let viewModel = factory.makeWalletDetailViewModel(wallet: wallet)
        viewModel.coordinator = self
        
        let viewController = factory.makeWalletDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromWalletDetail() {
        navigationController.popViewController(animated: true)
    }
}

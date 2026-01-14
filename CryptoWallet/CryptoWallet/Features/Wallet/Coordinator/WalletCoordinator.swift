import UIKit

class WalletCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showWallet()
    }
    
    func showWallet(title: String = "Wallet") {
        let viewController = builder.buildWalletViewController(title: title)
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showWalletDetail(wallet: Wallet) {
        let viewController = builder.buildWalletDetailViewController(wallet: wallet)
        viewController.viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromWalletDetail() {
        navigationController.popViewController(animated: true)
    }
}

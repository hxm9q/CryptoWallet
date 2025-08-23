import UIKit

protocol CoinListCoordinatorDelegate: AnyObject {
    func coinListDidRequestLogout()
}

class CoinListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: CoinListCoordinatorDelegate?
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showCoinList()
    }
    
    func showCoinList() {
        let viewController = builder.buildCoinListViewController()
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showCoinDetail(coin: Coin) {
        let detailViewController = builder.buildCoinDetailViewController(coin: coin)
        detailViewController.viewModel.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func goBackFromCoinDetail() {
        navigationController.popViewController(animated: true)
    }
    
    func logout() {
        delegate?.coinListDidRequestLogout()
    }
}

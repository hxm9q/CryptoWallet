import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authDidComplete()
    func authDidLogout()
}

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: AuthCoordinatorDelegate?
    private let factory: AuthFactoryProtocol
    
    init(navigationController: UINavigationController, factory: AuthFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
        setupLogoutObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        let viewModel = factory.makeAuthViewModel()
        viewModel.coordinator = self
        
        let viewController = factory.makeAuthViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func setupLogoutObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLogout),
            name: .didLogout,
            object: nil
        )
    }
    
    @objc private func handleLogout() {
        delegate?.authDidLogout()
    }
}

extension AuthCoordinator {
    func authenticationCompleted() {
        delegate?.authDidComplete()
    }
}

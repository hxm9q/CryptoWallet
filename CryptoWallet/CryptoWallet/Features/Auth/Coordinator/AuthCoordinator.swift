import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authDidComplete()
    func authDidLogout()
}

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: AuthCoordinatorDelegate?
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
        setupLogoutObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        showAuth()
    }
    
    func showAuth() {
        let viewController = builder.buildAuthViewController()
        viewController.viewModel.coordinator = self
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

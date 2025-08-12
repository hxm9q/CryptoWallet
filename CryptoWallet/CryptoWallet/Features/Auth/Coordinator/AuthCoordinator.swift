import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authDidComplete()
    func authDidLogout()
}

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: AuthCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupLogoutObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
        
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

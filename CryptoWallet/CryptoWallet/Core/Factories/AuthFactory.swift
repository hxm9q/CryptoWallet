import UIKit

protocol AuthFactoryProtocol {
    func makeAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator
    func makeAuthViewController(viewModel: AuthViewModel) -> AuthViewController
    func makeAuthViewModel() -> AuthViewModel
}

class AuthFactory: AuthFactoryProtocol {
    func makeAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeAuthViewController(viewModel: AuthViewModel) -> AuthViewController {
        return AuthViewController(viewModel: viewModel)
    }
    
    func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel()
    }
}

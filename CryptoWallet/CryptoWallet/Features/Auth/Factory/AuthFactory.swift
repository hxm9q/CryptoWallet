import UIKit

protocol AuthFactoryProtocol {
    func makeAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator
    func makeAuthViewController(viewModel: AuthViewModel) -> UIViewController
    func makeAuthViewModel() -> AuthViewModel
}

class AuthFactory: AuthFactoryProtocol {
    func makeAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeAuthViewController(viewModel: AuthViewModel) -> UIViewController {
        return AuthHostingController(viewModel: viewModel)
    }
    
    func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel()
    }
}

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let factory: ProfileFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ProfileFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewModel = factory.makeProfileViewModel(title: "Profile")
        viewModel.coordinator = self
        
        let viewController = factory.makeProfileViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showProfileDetail(profile: Profile) {
        let viewModel = factory.makeProfileDetailViewModel(profile: profile)
        viewModel.coordinator = self
        
        let viewController = factory.makeProfileDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromProfileDetail() {
        navigationController.popViewController(animated: true)
    }
}

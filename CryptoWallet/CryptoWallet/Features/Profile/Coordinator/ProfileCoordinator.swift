import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showProfile()
    }
    
    func showProfile(title: String = "Profile") {
        let viewController = builder.buildProfileViewController(title: title)
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showProfileDetail(profile: Profile) {
        let viewController = builder.buildProfileDetailViewController(profile: profile)
        viewController.viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromProfileDetail() {
        navigationController.popViewController(animated: true)
    }
}

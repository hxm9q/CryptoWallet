import UIKit

protocol ProfileFactoryProtocol {
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator
    
    func makeProfileViewController(viewModel: ProfileViewModel) -> ProfileViewController
    func makeProfileViewModel(title: String) -> ProfileViewModel
    
    func makeProfileDetailViewController(viewModel: ProfileDetailViewModel) -> ProfileDetailViewController
    func makeProfileDetailViewModel(profile: Profile) -> ProfileDetailViewModel
}

class ProfileFactory: ProfileFactoryProtocol {
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator {
        return ProfileCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeProfileViewController(viewModel: ProfileViewModel) -> ProfileViewController {
        return ProfileViewController(viewModel: viewModel)
    }
    
    func makeProfileViewModel(title: String) -> ProfileViewModel {
        return ProfileViewModel(title: title)
    }
    
    func makeProfileDetailViewController(viewModel: ProfileDetailViewModel) -> ProfileDetailViewController {
        return ProfileDetailViewController(viewModel: viewModel)
    }
    
    func makeProfileDetailViewModel(profile: Profile) -> ProfileDetailViewModel {
        return ProfileDetailViewModel(profile: profile)
    }
}

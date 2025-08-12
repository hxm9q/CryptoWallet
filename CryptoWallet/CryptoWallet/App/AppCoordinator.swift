import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        setupWindow()
    }
    
    private func setupWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func start() {
        checkAuthStatus()
    }
    
    private func checkAuthStatus() {
        let isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
        
        if isAuthorized {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }
    
    private func showMainFlow() {
        childCoordinators.removeAll { $0 is AuthCoordinator }
        
        let mainTabBarController = MainTabBarController()
        navigationController.setViewControllers([mainTabBarController], animated: true)
    }
    
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.delegate = self
        addChild(authCoordinator)
        authCoordinator.start()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func authDidComplete() {
        showMainFlow()
    }
    
    func authDidLogout() {
        showAuthFlow()
    }
}

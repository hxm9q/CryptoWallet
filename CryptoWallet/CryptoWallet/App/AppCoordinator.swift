import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var window: UIWindow?
    private let builder: ViewControllerBuilderProtocol
    
    init(window: UIWindow?, builder: ViewControllerBuilderProtocol) {
        self.window = window
        self.builder = builder
        self.navigationController = UINavigationController()
    }
    
    private func setupWindow(rootViewController: UIViewController) {
        window?.rootViewController = rootViewController
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
        
        let mainCoordinator = builder.buildMainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        addChild(mainCoordinator)
        mainCoordinator.start()
        
        if let tabBarController = mainCoordinator.tabBarController {
            setupWindow(rootViewController: tabBarController)
        }
    }
    
    private func showAuthFlow() {
        let authCoordinator = builder.buildAuthCoordinator(navigationController: navigationController)
        authCoordinator.delegate = self
        addChild(authCoordinator)
        authCoordinator.start()
        
        setupWindow(rootViewController: navigationController)
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

extension AppCoordinator: MainCoordinatorDelegate {
    func makeDidRequestLogout() {
        UserDefaults.standard.set(false, forKey: "isAuthorized")
        showAuthFlow()
    }
}

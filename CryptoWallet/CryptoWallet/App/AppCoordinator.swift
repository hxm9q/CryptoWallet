import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var window: UIWindow?
    private let factory: AppFactoryProtocol
    
    init(window: UIWindow?, factory: AppFactoryProtocol) {
        self.window = window
        self.factory = factory
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
        
        let mainCoordinator = factory.mainFactory.makeMainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        addChild(mainCoordinator)
        mainCoordinator.start()
        
        if let tabBarController = mainCoordinator.tabBarController {
            setupWindow(rootViewController: tabBarController)
        }
    }
    
    private func showAuthFlow() {
        let authCoordinator = factory.authFactory.makeAuthCoordinator(navigationController: navigationController)
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

import UIKit

protocol AppFactoryProtocol {
    var authFactory: AuthFactoryProtocol { get }
    var mainFactory: MainFactoryProtocol { get }
    func makeAppCoordinator(window: UIWindow?) -> AppCoordinator
}

class AppFactory: AppFactoryProtocol {
    lazy var authFactory: AuthFactoryProtocol = AuthFactory()
    lazy var mainFactory: MainFactoryProtocol = MainFactory()
    
    func makeAppCoordinator(window: UIWindow?) -> AppCoordinator {
        return AppCoordinator(window: window, factory: self)
    }
}

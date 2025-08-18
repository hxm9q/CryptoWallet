import UIKit

class ArticleCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let factory: ArticleFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ArticleFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewModel = factory.makeArticleViewModel(title: "Articles")
        viewModel.coordinator = self
        
        let viewController = factory.makeArticleViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showArticleDetail(article: Article) {
        let viewModel = factory.makeArticleDetailViewModel(article: article)
        viewModel.coordinator = self
        
        let viewController = factory.makeArticleDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBackFromArticleDetail() {
        navigationController.popViewController(animated: true)
    }
}

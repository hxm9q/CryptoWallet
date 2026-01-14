import UIKit

class ArticleCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let builder: ViewControllerBuilderProtocol
    
    init(navigationController: UINavigationController, builder: ViewControllerBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        showArticle()
    }
    
    func showArticle(title: String = "Articles") {
        let viewController = builder.buildArticleViewController(title: title)
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showArticleDetail(article: Article) {
        let detailViewController = builder.buildArticleDetailViewController(article: article)
        detailViewController.viewModel.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func goBackFromArticleDetail() {
        navigationController.popViewController(animated: true)
    }
}

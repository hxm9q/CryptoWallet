import UIKit

protocol ArticleFactoryProtocol {
    func makeArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator
    
    func makeArticleViewController(viewModel: ArticleViewModel) -> ArticleViewController
    func makeArticleViewModel(title: String) -> ArticleViewModel
    
    func makeArticleDetailViewController(viewModel: ArticleDetailViewModel) -> ArticleDetailViewController
    func makeArticleDetailViewModel(article: Article) -> ArticleDetailViewModel
}

class ArticleFactory: ArticleFactoryProtocol {
    func makeArticleCoordinator(navigationController: UINavigationController) -> ArticleCoordinator {
        return ArticleCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeArticleViewController(viewModel: ArticleViewModel) -> ArticleViewController {
        return ArticleViewController(viewModel: viewModel)
    }
    
    func makeArticleViewModel(title: String) -> ArticleViewModel {
        return ArticleViewModel(title: title)
    }
    
    func makeArticleDetailViewController(viewModel: ArticleDetailViewModel) -> ArticleDetailViewController {
        return ArticleDetailViewController(viewModel: viewModel)
    }
    
    func makeArticleDetailViewModel(article: Article) -> ArticleDetailViewModel {
        return ArticleDetailViewModel(article: article)
    }
}

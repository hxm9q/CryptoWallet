import UIKit

final class ArticleDetailViewModel {
    
    weak var coordinator: ArticleCoordinator?
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var articleTitle: String {
        return article.title
    }
    
    var articleAuthor: String {
        return article.author
    }
    
    var articleReadTime: String {
        return article.readTime
    }
    
    func goBack() {
        coordinator?.goBackFromArticleDetail()
    }
}

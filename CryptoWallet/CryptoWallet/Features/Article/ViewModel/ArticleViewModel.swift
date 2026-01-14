import UIKit

final class ArticleViewModel {
    
    weak var coordinator: ArticleCoordinator?
    
    let title: String
    var articles: [Article] = []
    
    init(title: String) {
        self.title = title
    }
    
    func loadArticles() {
        articles = [ Article(title: "Market cycles", author: "Vitalik Buterin", readTime: "10 min") ]
    }
    
    func showArticleDetail() {
        let marketArticle = articles[0]
        coordinator?.showArticleDetail(article: marketArticle)
    }
}

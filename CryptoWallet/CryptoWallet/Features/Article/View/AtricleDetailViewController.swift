import UIKit

class ArticleDetailViewController: UIViewController {
    
    let viewModel: ArticleDetailViewModel
    
    // MARK: - Init
    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.text = "Title: \(viewModel.articleTitle)"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        let authorLabel = UILabel()
        authorLabel.text = "Author: \(viewModel.articleAuthor)"
        authorLabel.font = .systemFont(ofSize: 18, weight: .medium)
        authorLabel.textAlignment = .center
        
        let readTimeLabel = UILabel()
        readTimeLabel.text = "Approximate time: \(viewModel.articleReadTime)"
        readTimeLabel.font = .systemFont(ofSize: 18, weight: .medium)
        readTimeLabel.textAlignment = .center
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Articles", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, readTimeLabel, backButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func goBack() {
        viewModel.goBack()
    }
}

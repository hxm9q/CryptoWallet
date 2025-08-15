import UIKit

class WalletDetailViewController: UIViewController {
    
    private let viewModel: WalletDetailViewModel
    
    // MARK: - Init
    init(viewModel: WalletDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.text = viewModel.walletTitle
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        let priceLabel = UILabel()
        priceLabel.text = viewModel.amountInfo
        priceLabel.font = .systemFont(ofSize: 18, weight: .medium)
        priceLabel.textAlignment = .center
        
        let dateLabel = UILabel()
        dateLabel.text = viewModel.dateInfo
        dateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        dateLabel.textAlignment = .center
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Wallet", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, dateLabel, backButton])
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

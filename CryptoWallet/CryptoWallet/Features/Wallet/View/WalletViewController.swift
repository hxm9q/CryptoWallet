import UIKit

class WalletViewController: UIViewController {
    
    private let viewModel: WalletViewModel
    
    // MARK: - Init
    init(viewModel: WalletViewModel) {
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
        viewModel.loadTransactions()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        let titleLabel = UILabel()
        titleLabel.text = viewModel.title
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        let stockButton = UIButton(type: .system)
        stockButton.setTitle("View Transaction Details", for: .normal)
        stockButton.backgroundColor = .systemBlue
        stockButton.setTitleColor(.white, for: .normal)
        stockButton.layer.cornerRadius = 8
        stockButton.addTarget(self, action: #selector(showWalletDetail), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, stockButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stockButton.widthAnchor.constraint(equalToConstant: 200),
            stockButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func showWalletDetail() {
        viewModel.showWalletDetail()
    }
}

import UIKit

class ProfileDetailViewController: UIViewController {
    
    private let viewModel: ProfileDetailViewModel
    
    // MARK: - Init
    init(viewModel: ProfileDetailViewModel) {
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
        
        let nameLabel = UILabel()
        nameLabel.text = viewModel.profileName
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textAlignment = .center
        
        let emailLabel = UILabel()
        emailLabel.text = viewModel.profileEmail
        emailLabel.font = .systemFont(ofSize: 18, weight: .medium)
        emailLabel.textAlignment = .center
        
        let settingsLabel = UILabel()
        settingsLabel.text = viewModel.profileSettings
        settingsLabel.numberOfLines = 0
        settingsLabel.font = .systemFont(ofSize: 18, weight: .medium)
        settingsLabel.textAlignment = .center
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Profile", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel, settingsLabel, backButton])
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

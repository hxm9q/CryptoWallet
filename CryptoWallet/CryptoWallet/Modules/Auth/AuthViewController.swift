import UIKit
import Combine
import SnapKit

class AuthViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    // MARK: - Constants
    
    private enum Constants {
        static let backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1)
        static let buttonColor = UIColor(red: 25/255, green: 28/255, blue: 50/255, alpha: 1)
        static let logoSize: CGFloat = 287
        static let textFieldSize = CGSize(width: 325, height: 55)
        static let textFieldCornerRadius: CGFloat = 25
        static let buttonCornerRadius: CGFloat = 28
    }
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView()
    private let userImageView = UIImageView()
    private let passwordImageView = UIImageView()
    
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    
    private let loginButton = UIButton()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        setupLayout()
        setupUI()
    }
}

// MARK: - Setup Layout
private extension AuthViewController {
    
    func setupLayout() {
        
        [logoImageView, usernameField, passwordField, loginButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.logoSize)
        }
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(474)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.textFieldSize)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(544)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.textFieldSize)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(624)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
        
    }
}

// MARK: - Setup UI
private extension AuthViewController {
    
    func setupUI() {
        
        // MARK: Logo
        logoImageView.image = UIImage(named: "Group 79logo")
        logoImageView.contentMode = .scaleAspectFill
        
        // MARK: Username
        let userImageView = UIImageView(image: UIImage(named: "user"))
        userImageView.contentMode = .scaleAspectFit
        userImageView.frame = CGRect(x: 6, y: 6, width: 32, height: 32)
        
        let userImageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userImageContainer.addSubview(userImageView)
        
        usernameField.placeholder = "Username"
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        usernameField.returnKeyType = .next
        usernameField.backgroundColor = .white
        usernameField.layer.cornerRadius = Constants.textFieldCornerRadius
        usernameField.clearButtonMode = .whileEditing
        usernameField.leftView = userImageContainer
        usernameField.leftViewMode = .always
        
        // MARK: Password
        let passwordImageView = UIImageView(image: UIImage(named: "password"))
        passwordImageView.contentMode = .scaleAspectFit
        passwordImageView.frame = CGRect(x: 6, y: 6, width: 32, height: 32)
        
        let passwordImageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        passwordImageContainer.addSubview(passwordImageView)
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.backgroundColor = .white
        passwordField.layer.cornerRadius = Constants.textFieldCornerRadius
        passwordField.clearButtonMode = .whileEditing
        passwordField.leftView = passwordImageContainer
        passwordField.leftViewMode = .always
        
        // MARK: Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = Constants.buttonColor
        loginButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
}

#Preview(traits: .portrait) {
    AuthViewController()
}

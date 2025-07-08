import UIKit
import Combine
import SnapKit

class AuthViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constants
    private enum AuthConstants {
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
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupUI()
        setupLayout()
        bindViewModel()
        viewModel.loadAuthorizationState()
    }
}

// MARK: - Setup View
private extension AuthViewController {
    
    func setupView() {
        view.backgroundColor = AuthConstants.backgroundColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - Setup UI
private extension AuthViewController {
    
    func setupUI() {
        // MARK: Logo
        logoImageView.image = UIImage(named: "auth_logo")
        logoImageView.contentMode = .scaleAspectFill
        
        // MARK: Username
        let userImageView = UIImageView(image: UIImage(named: "user"))
        userImageView.contentMode = .scaleAspectFit
        userImageView.frame = CGRect(x: 6, y: 6, width: 32, height: 32)
        
        let userImageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userImageContainer.addSubview(userImageView)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        usernameTextField.returnKeyType = .next
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = AuthConstants.textFieldCornerRadius
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.leftView = userImageContainer
        usernameTextField.leftViewMode = .always
        
        // MARK: Password
        let passwordImageView = UIImageView(image: UIImage(named: "password"))
        passwordImageView.contentMode = .scaleAspectFit
        passwordImageView.frame = CGRect(x: 6, y: 6, width: 32, height: 32)
        
        let passwordImageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        passwordImageContainer.addSubview(passwordImageView)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.returnKeyType = .done
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = AuthConstants.textFieldCornerRadius
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.leftView = passwordImageContainer
        passwordTextField.leftViewMode = .always
        
        // MARK: Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = AuthConstants.buttonColor
        loginButton.layer.cornerRadius = AuthConstants.buttonCornerRadius
    }
}

// MARK: - Setup Layout
private extension AuthViewController {
    
    func setupLayout() {
        [logoImageView, usernameTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        let usernameTopOffset: CGFloat = screenHeight < 668 ? 85 : 174
        let loginButtonBottomOffset: CGFloat = screenHeight < 668 ? 59 : 133
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(AuthConstants.logoSize)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(usernameTopOffset)
            make.centerX.equalToSuperview()
            make.size.equalTo(AuthConstants.textFieldSize)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(AuthConstants.textFieldSize)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(AuthConstants.textFieldSize.width)
            make.height.equalTo(AuthConstants.textFieldSize.height)
            make.bottom.equalToSuperview().offset(-loginButtonBottomOffset)
        }
    }
}

// MARK: - ViewModel Binding
private extension AuthViewController {
    
    func bindViewModel() {
        usernameTextField.addTarget(self, action: #selector(usernameTextChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error = error else { return }
                self?.showAlert(message: error)
            }
            .store(in: &cancellables)
        
        viewModel.$isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAuth in
                if isAuth {
                    self?.showCoinListTabBar()
                }
            }
            .store(in: &cancellables)
    }
    
    func showCoinListTabBar() {
        let vc = CoinListTabBarController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else {
            return
        }
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

// MARK: - Alert Handling
extension AuthViewController {
    
    func alertConfiguration(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let repeatAction = UIAlertAction(title: "Повторить", style: .default)
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive) { [weak self] _ in
            self?.clearFields()
        }
        
        alert.addAction(repeatAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    func clearFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        viewModel.username = ""
        viewModel.password = ""
    }
    
    func showAlert(message: String) {
        present(alertConfiguration(message: message), animated: true)
    }
}

// MARK: - Actions
extension AuthViewController {
    
    @objc func usernameTextChanged() {
        viewModel.username = usernameTextField.text ?? ""
    }
    
    @objc func passwordTextChanged() {
        viewModel.password = passwordTextField.text ?? ""
    }
    
    @objc func loginButtonTapped() {
        view.endEditing(true)
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Пожалуйста, введите логин")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Пожалуйста, введите пароль")
            return
        }
        
        viewModel.loginUser()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            loginButtonTapped()
        }
        return true
    }
}

// MARK: - Preview
#Preview {
    AuthViewController()
}

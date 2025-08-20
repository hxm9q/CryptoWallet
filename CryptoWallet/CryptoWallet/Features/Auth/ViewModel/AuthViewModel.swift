import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published private(set) var isAuthorized: Bool = false
    @Published private(set) var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    weak var coordinator: AuthCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    func loginUser() {
        guard !username.isEmpty else {
            showErrorAlert("Пожалуйста, введите логин")
            return
        }
        
        guard !password.isEmpty else {
            showErrorAlert("Пожалуйста, введите пароль")
            return
        }
        
        if username == "1234" && password == "1234" {
            isAuthorized = true
            errorMessage = nil
            showError = false
            
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            
            coordinator?.authenticationCompleted()
        } else {
            isAuthorized = false
            errorMessage = "Введены неправильный логин или пароль"
            showError = true
        }
    }
    
    private func showErrorAlert(_ message: String) {
        errorMessage = message
        showError = true
    }
    
    func logout() {
        isAuthorized = false
        UserDefaults.standard.set(false, forKey: "isAuthorized")
        username = ""
        password = ""
        
        NotificationCenter.default.post(name: .didLogout, object: nil)
    }
    
    func loadAuthorizationState() {
        let saved = UserDefaults.standard.bool(forKey: "isAuthorized")
        isAuthorized = saved
        
        if saved {
            coordinator?.authenticationCompleted()
        }
    }
    
    func clearFields() {
        username = ""
        password = ""
        errorMessage = nil
        showError = false
    }
}

extension Notification.Name {
    static let didLogout = Notification.Name("didLogout")
}

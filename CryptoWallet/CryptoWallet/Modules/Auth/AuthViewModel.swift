import Foundation
import Combine

class AuthViewModel {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published private(set) var isAuthorized: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func loginUser() {
        
        if username == "1234" && password == "1234" {
            isAuthorized = true
            errorMessage = nil
            
            UserDefaults.standard.set(true, forKey: "isAuthorized")
        } else {
            isAuthorized = false
            errorMessage = "Введены неправильный логин или пароль"
        }
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
    }
}

extension Notification.Name {
    static let didLogout = Notification.Name("didLogout")
}

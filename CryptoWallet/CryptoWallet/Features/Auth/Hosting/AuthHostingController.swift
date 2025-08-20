import UIKit
import SwiftUI

class AuthHostingController: UIHostingController<AuthView> {
    private let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        let authView = AuthView(viewModel: AuthViewModel())
        super.init(rootView: authView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

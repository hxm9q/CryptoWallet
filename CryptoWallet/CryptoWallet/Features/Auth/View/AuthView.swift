import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    @FocusState private var focusedField: Field?
    
    private struct AuthConstants {
        static let backgroundColor = Color(red: 243/255, green: 245/255, blue: 246/255)
        static let loginButtonColor = Color(red: 25/255, green: 28/255, blue: 50/255)
        
        static let logoSize: CGFloat = 287
        static let logoOffset: CGFloat = 174
        static let fieldIconSize: CGFloat = 32
        static let elementWidth: CGFloat = 325
        static let elementHeight: CGFloat = 55
    }
    
    private enum Field {
        case username, password
    }
    
    var body: some View {
        
        ZStack {
            AuthConstants.backgroundColor.ignoresSafeArea()

            ScrollView {
                
                VStack {
                    logoImage
                    Spacer(minLength: AuthConstants.logoOffset)
                    usernameTextField
                    passwordTextField
                    loginButton
                    Spacer()
                }
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .alert("Ошибка", isPresented: $viewModel.showError) {
            Button("Повторить", role: .none) {}
            Button("Отменить", role: .cancel) {
                viewModel.clearFields()
            }
        } message: {
            Text(viewModel.errorMessage ?? "Неизвестная ошибка")
        }
        .onAppear {
            viewModel.loadAuthorizationState()
        }
    }
}

// MARK: - Logo Image
private extension AuthView {
    
    var logoImage: some View {
        Image("auth_logo")
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(maxWidth: AuthConstants.logoSize, maxHeight: AuthConstants.logoSize)
            .padding(.top, 13)
            .padding(.horizontal, 44)
    }
}

// MARK: - Username Text Field
private extension AuthView {
    
    var usernameTextField: some View {
        HStack(spacing: 0) {
            userImage
            userTextField
            
            if !viewModel.username.isEmpty {
                Button {
                    viewModel.username = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray.opacity(0.4))
                        .padding(.trailing, 12)
                }
            } else {
                Spacer().frame(width: 32)
            }
        }
        .frame(width: AuthConstants.elementWidth, height: AuthConstants.elementHeight)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    var userImage: some View {
        Image("user")
            .resizable()
            .scaledToFit()
            .frame(width: AuthConstants.fieldIconSize, height: AuthConstants.fieldIconSize)
            .padding(.leading, 10)
    }
    
    var userTextField: some View {
        TextField("Username", text: $viewModel.username)
            .textFieldStyle(.plain)
            .textInputAutocapitalization(nil)
            .autocorrectionDisabled()
            .focused($focusedField, equals: .username)
            .onSubmit {
                focusedField = .password
            }
            .submitLabel(.next)
            .padding(.leading, 15)
    }
}

// MARK: - Password Text Field
private extension AuthView {
    
    var passwordTextField: some View {
        HStack(spacing: 0) {
            passwordImage
            passTextField
            
            if !viewModel.password.isEmpty {
                Button {
                    viewModel.password = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray.opacity(0.4))
                        .padding(.trailing, 12)
                }
            } else {
                Spacer().frame(width: 32)
            }
        }
        .frame(width: AuthConstants.elementWidth, height: AuthConstants.elementHeight)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.top, 15)
    }
    
    var passwordImage: some View {
        Image("password")
            .resizable()
            .scaledToFit()
            .frame(width: AuthConstants.fieldIconSize, height: AuthConstants.fieldIconSize)
            .padding(.leading, 10)
    }
    
    var passTextField: some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(.plain)
            .textInputAutocapitalization(nil)
            .autocorrectionDisabled()
            .focused($focusedField, equals: .password)
            .onSubmit {
                focusedField = nil
                viewModel.loginUser()
            }
            .submitLabel(.return)
            .padding(.leading, 15)
    }
}

// MARK: - Login Button
private extension AuthView {
    
    var loginButton: some View {
        Button {
            focusedField = nil
            viewModel.loginUser()
        } label: {
            Text("Login")
                .foregroundStyle(.white)
        }
        .frame(width: AuthConstants.elementWidth, height: AuthConstants.elementHeight)
        .background(AuthConstants.loginButtonColor).clipShape(RoundedRectangle(cornerRadius: 40))
        .padding(.top, 15)
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel())
}

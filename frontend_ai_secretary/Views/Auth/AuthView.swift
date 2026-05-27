import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(isLoginMode ? "З поверненням!" : "Створити акаунт")
                    .font(.largeTitle)
                    .bold()
                
                // Форма Email
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Пароль", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                // Вивід помилок
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // Головна кнопка (Вхід / Реєстрація)
                Button(action: {
                    Task {
                        if isLoginMode {
                            await viewModel.signIn(email: email, password: password)
                        } else {
                            await viewModel.signUp(email: email, password: password)
                        }
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text(isLoginMode ? "Увійти" : "Зареєструватися")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Перемикач режимів
                Button(action: { isLoginMode.toggle() }) {
                    Text(isLoginMode ? "Немає акаунту? Реєстрація" : "Вже є акаунт? Увійти")
                        .foregroundColor(.blue)
                }
                
                Divider()
                    .padding(.vertical)
                
                // Соціальні кнопки
                VStack(spacing: 15) {
//                    Button(action: { viewModel.signInWithApple() }) {
//                        Text("Sign in with Apple")
//                            .bold()
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.black)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.signInWithGoogle() // 👈 Додали Task та await
                        }
                    }) {
                        Text("Sign in with Google")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}
#Preview {
    AuthView()
}

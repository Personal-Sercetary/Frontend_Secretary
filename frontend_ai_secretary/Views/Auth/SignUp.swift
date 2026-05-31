import SwiftUI

struct SignUp: View {
    @Environment(\.dismiss) var dismiss // Для повернення назад
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var localError: String? = nil
    
    // Змінні для показу/приховування паролів
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false

    var body: some View {
        ZStack {
            // 1. Головний фон екрану
            Color("bg-1")
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }

            // 📦 2. ГОЛОВНА КАРТКА
            VStack {
                
                // --- БЛОК 1: Заголовок та кнопка назад ---
                VStack(alignment: .leading, spacing: 15) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.bottom, 5)
                    
                    Text("Create an account")
                        .foregroundColor(Color("tx-1"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Join AI Secretary today. Please enter your details below.")
                        .font(.subheadline)
                        .foregroundColor(Color("tx-2"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer() // 🟢 Розподіл простору
                
                // --- БЛОК 2: Форма введення ---
                VStack(spacing: 35) {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        CustomInputField(
                                    title: "Email address",
                                    iconName: "envelope",
                                    placeholder: "Enter your email address",
                                    text: $email,
                                    keyboardType: .emailAddress,
                                    textContentType: .emailAddress
                                )
                                
                                // --- ПАРОЛЬ ---
                                CustomInputField(
                                    title: "Password",
                                    iconName: "lock",
                                    placeholder: "Enter your password",
                                    text: $password,
                                    isPassword: true,
                                    textContentType: .newPassword
                                )
                                
                                // --- ПІДТВЕРДЖЕННЯ ПАРОЛЯ ---
                                CustomInputField(
                                    title: "Confirm Password",
                                    iconName: "lock",
                                    placeholder: "Confirm your password",
                                    text: $confirmPassword,
                                    isPassword: true,
                                    textContentType: .newPassword
                                )
                        // --- ПОМИЛКИ ---
                        if let error = localError ?? viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        // --- КНОПКА РЕЄСТРАЦІЇ ---
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Button("Sign Up") {
                                if password == confirmPassword {
                                    localError = nil
                                    Task { await viewModel.signUp(email: email, password: password) }
                                } else {
                                    localError = "Passwords do not match"
                                }
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .padding(.top, 10)
                        }
                    }
                }
                
                Spacer() // 🟢 2. Розподіл простору
                
                // --- БЛОК 3: Альтернативний вхід ---
                VStack(spacing: 25) {
                    HStack {
                        Rectangle().frame(height: 0.5).foregroundColor(Color(.separator))
                        Text("Or sign up with...").font(.caption).foregroundColor(.secondary)
                        Rectangle().frame(height: 0.5).foregroundColor(Color(.separator))
                    }
                    
                    SocialSignInButton(text: "Google") {
                        await viewModel.signInWithGoogle()
                    }
                    .disabled(viewModel.isLoading)
                }
                
                Spacer() // 🟢 3. Розподіл простору
                
                // --- БЛОК 4: Перехід на логін та Умови ---
                VStack(spacing: 20) {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.secondary)
                        Button(action: { dismiss() }) { // Повертає на сторінку входу
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(Color("tx-1"))
                        }
                    }
                    .font(.subheadline)
                    
                    Text("By signing up you agree to the Terms of Services and Privacy Policy.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
            }
            // Налаштування контейнера (картки)
            .padding(.horizontal, 24)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg-2"))
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color(.separator), lineWidth: 1) // Можеш змінити колір та товщину
            )
            .padding(16)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarHidden(true)
    }
}

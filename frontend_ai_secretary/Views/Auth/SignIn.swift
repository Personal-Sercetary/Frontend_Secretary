import SwiftUI

struct SignIn: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var isPasswordVisible: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var stayLoggedIn = false
    
    var body: some View {
        ZStack {
            // 1. Головний фон екрану
            Color("bg-1").ignoresSafeArea()
            
            // 📦 2. ГОЛОВНА КАРТКА
            VStack {
                
                // --- БЛОК 1: Заголовок ---
                VStack(alignment: .leading, spacing: 15) {
                    Text("Welcome")
                        .foregroundColor(Color("tx-1")) // Перевір, чи є в тебе розширення Color, або юзай Color("titleText")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Continue your journey with rooted warmth. Please enter your details below.")
                        .font(.subheadline)
                        .foregroundColor(.text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer() 
                
                // --- БЛОК 2: Форма введення ---
                VStack(spacing: 35) {
                        VStack(alignment: .leading, spacing: 15) {
                            
                            // 1. Поле Email
                            CustomInputField(
                                title: "Email address",
                                iconName: "envelope",
                                placeholder: "Enter your email address",
                                text: $email,
                                keyboardType: .emailAddress,
                                textContentType: .emailAddress
                            )
                            
                            // 2. Поле Password
                            CustomInputField(
                                title: "Password",
                                iconName: "lock",
                                placeholder: "Enter your password",
                                text: $password,
                                isPassword: true, // Вмикає режим пароля (крапки + око)
                                textContentType: .password
                            )
                            
                        }
                    
                    // Чекбокс та "Забули пароль"
                    HStack {
                        Toggle("", isOn: $stayLoggedIn)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                            .labelsHidden()
                        
                        Text("Stay logged in")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Button("Forgot Password?") {}
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    // Кнопка входу
                    if viewModel.isLoading {
                        ProgressView().padding()
                    } else {
                        Button("Login") {
                            Task { await viewModel.signIn(email: email, password: password) }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                }
                
                Spacer()
                
                VStack(spacing: 35) {
                    HStack {
                        Rectangle().frame(height: 0.5).foregroundColor(Color(.separator))
                        Text("Or continue with...").font(.caption).foregroundColor(.secondary)
                        Rectangle().frame(height: 0.5).foregroundColor(Color(.separator))
                    }
                    
                    SocialSignInButton(text: "Google") {
                        await viewModel.signInWithGoogle()
                    }
                    .disabled(viewModel.isLoading)
                }
                
                Spacer() // 🟢 3. Штовхає текст реєстрації в самий низ картки
                
                // --- БЛОК 4: Перехід на реєстрацію ---
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    NavigationLink(destination: SignUp(viewModel: viewModel)) {
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color("tx-1"))
                    }
                }
                .font(.subheadline)
                
            }
            .padding(.horizontal,24)
            .padding(.vertical,60)// Внутрішні відступи
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Розтягуємо на весь екран
            .background(Color("bg-2")) // Світлий фон картки
            .cornerRadius(35) // Закруглення
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color(.separator), lineWidth: 2) // Можеш змінити колір та товщину
            )
            .padding(16) // Зовнішні відступи від країв телефона
            .onTapGesture {
                hideKeyboard() // 👈 Клавіатура ховатиметься при кліку на саму картку (поза полями)
            }
        }
        .navigationBarHidden(true)
    }
}


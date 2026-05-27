
import Foundation
import Supabase
import SwiftUI
import Combine
import AuthenticationServices
@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init() {
        Task {
            await checkSession()
        }
    }
    
    func checkSession() async {
        do {
            let _ = try await SupabaseManager.client.auth.session
            self.isAuthenticated = true
        } catch {
            self.isAuthenticated = false
        }
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            try await SupabaseManager.client.auth.signIn(email: email, password: password)
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription // Ось так ми дістаємо текст помилки
        }
    }
     
    func signUp(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let response = try await SupabaseManager.client.auth.signUp(
                email: email,
                password: password
            )
            print("✅ SignUp response: \(response)")
            isAuthenticated = true
        } catch {
            print("❌ SignUp error: \(error)")
            errorMessage = error.localizedDescription
        }
    }
    
    func signInWithGoogle() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // 1. Отримуємо URL для логіну від Supabase
            let url = try await SupabaseManager.client.auth.getOAuthSignInURL(
                provider: .google,
                redirectTo: URL(string: "aisecretary://login-callback")! // Схема, яку ви вказали в Xcode
            )
            
            // 2. Відкриваємо системне вікно авторизації
            let session = ASWebAuthenticationSession(
                url: url,
                callbackURLScheme: "aisecretary"
            ) { callbackURL, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                if let callbackURL = callbackURL {
                    Task {
                        do {
                            // 3. Передаємо результат назад у Supabase
                            try await SupabaseManager.client.auth.session(from: callbackURL)
                            await MainActor.run {
                                self.isAuthenticated = true
                            }
                        } catch {
                            await MainActor.run {
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
            }
            
            session.presentationContextProvider = WindowContextProvider()
            session.start()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}


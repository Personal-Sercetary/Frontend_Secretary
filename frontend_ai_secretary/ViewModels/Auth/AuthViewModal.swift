import Foundation
import Supabase
import SwiftUI
import Combine
import GoogleSignIn

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
            print("✅ SignUp response: ")
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
        errorMessage = nil
        defer { isLoading = false }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            errorMessage = "Не вдалось знайти вікно"
            return
        }
        
        do {
            // 1. Нативний Google Sign In
            let result = try await GIDSignIn.sharedInstance.signIn(
                withPresenting: rootViewController
            )
            
            guard let idToken = result.user.idToken?.tokenString else {
                errorMessage = "Не вдалось отримати токен"
                return
            }
            
            // 2. Передаємо токен в Supabase
            try await SupabaseManager.client.auth.signInWithIdToken(
                credentials: .init(
                    provider: .google,
                    idToken: idToken,
                    accessToken: result.user.accessToken.tokenString
                )
            )
            
            isAuthenticated = true
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func signOut() async {
            isLoading = true
            errorMessage = nil
            defer { isLoading = false }
            
            do {
                // 1. Виходимо з Supabase
                try await SupabaseManager.client.auth.signOut()
                
                // 2. Виходимо з локального Google SDK (щоб забути обраний акаунт)
                GIDSignIn.sharedInstance.signOut()
                
                // 3. Змінюємо стан додатку
                isAuthenticated = false
                print("✅ Користувач успішно вийшов")
            } catch {
                errorMessage = error.localizedDescription
                print("❌ Помилка виходу: \(error)")
            }
        }
}


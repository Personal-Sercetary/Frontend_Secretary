import SwiftUI
import SwiftData
import GoogleSignIn // 👈 Обов'язково імпортуємо GoogleSignIn

@main
struct frontend_ai_secretaryApp: App {
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .onOpenURL { url in
                    // 1. Перехоплюємо URL від Google після успішного або скасованого входу
                    GIDSignIn.sharedInstance.handle(url)
                    
                    // 2. Перехоплюємо URL від Supabase (якщо ви використовуєте підтвердження email)
                    // Розкоментуйте цей рядок, якщо використовуєте підтвердження через пошту
                    /*
                    Task {
                        try? await SupabaseManager.shared.client.auth.session(from: url)
                    }
                    */
                }
        }
        // 3. Підключаємо локальну базу даних (замініть TaskModel на вашу основну модель)
        // Якщо у вас поки немає моделі, залиште це закоментованим:
        // .modelContainer(for: TaskModel.self)
    }
}

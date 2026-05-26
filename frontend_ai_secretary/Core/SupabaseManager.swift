import Foundation
import Supabase

enum AppSecrets { // Змінили назву тут
    static let supabaseUrl: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨 Не знайдено SUPABASE_URL в Info.plist")
        }
        return url
    }()

    static let supabaseKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
            fatalError("🚨 Не знайдено SUPABASE_ANON_KEY в Info.plist")
        }
        return key
    }()
}

// Використовуємо нову назву AppSecrets
let supabase = SupabaseClient(supabaseURL: AppSecrets.supabaseUrl, supabaseKey: AppSecrets.supabaseKey)

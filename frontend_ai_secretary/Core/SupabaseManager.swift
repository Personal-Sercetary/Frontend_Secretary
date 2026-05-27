import Foundation
import Supabase

enum SupabaseManager {
    private static let supabaseUrl: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
              !urlString.isEmpty,
              let url = URL(string: urlString) else {
            return URL(string: "https://placeholder.supabase.co")!
        }
        return url
    }()

    private static let supabaseKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String,
              !key.isEmpty else {
            return "placeholder-key"
        }
        return key
    }()

    static let client = SupabaseClient(
        supabaseURL: supabaseUrl,
        supabaseKey: supabaseKey,
        options: SupabaseClientOptions(
            auth: SupabaseClientOptions.AuthOptions(
                emitLocalSessionAsInitialSession: true
            )
        )
    )
}

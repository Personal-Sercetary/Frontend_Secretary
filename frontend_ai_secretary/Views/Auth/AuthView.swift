import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                // ТУТ БУДЕ ТВІЙ ГОЛОВНИЙ ЕКРАН ДОДАТКА
                VStack {
                    Text("Вітаємо в AI Secretary!")
                        .font(.title)
                    Button(action: {
                        Task {
                            await viewModel.signOut()
                        }
                    }) {
                        Text("Вийти")
                            .foregroundColor(.red)
                    }
                    .padding()
                }
            } else {
                // Якщо не авторизований - показуємо навігаційний стек авторизації
                NavigationStack {
                    SignIn(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    AuthView()
}

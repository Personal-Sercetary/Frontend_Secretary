import SwiftUI

struct AIOptimizationBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 16))
                    .foregroundColor(Color("accent"))
                Text("AI Optimization")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("tx-1"))
            }

            Text("Аналіз продуктивності за останній тиждень готовий до перегляду.")
                .font(.subheadline)
                .foregroundColor(Color("tx-2"))
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {}) {
                Text("Переглянути звіт")
                    .font(.subheadline)
                    .foregroundColor(Color("tx-2"))
                    .underline()
            }
        }
        .padding(16)
        .background(Color("bg-2"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("bd-1"), lineWidth: 0.5)
        )
    }
}

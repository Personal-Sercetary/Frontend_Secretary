import SwiftUI

struct SocialSignInButton: View {
    var text: String
    var action: () async -> Void

    var body: some View {
        Button(action: {
            Task { await action() }
        }) {
            HStack {
                // Переконайся, що в Assets є "google_logo"
//                Image("google_logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 24, height: 24)
                Text(text)
                    .foregroundColor(.black)
                    .font(.body)
            }
            .padding(.vertical,10)
            .padding(.horizontal,20)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.separator), lineWidth: 0.5)
            )
        }
    }
}


import SwiftUI

struct FABMenuView: View {
    @Binding var isExpanded: Bool
    var onVoice: () -> Void
    var onMenu: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Димове тло
            if isExpanded {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation(.spring(response: 0.3)) { isExpanded = false } }
                    .transition(.opacity)
            }

            VStack(alignment: .trailing, spacing: 12) {
                // Меню опції
                if isExpanded {
                    VStack(alignment: .leading, spacing: 0) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) { isExpanded = false }
                            onMenu()
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "bubble.left.and.bubble.right")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("accent"))
                                Text("Чат")
                                    .font(.body)
                                    .foregroundColor(Color("tx-1"))
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                        }

                        Divider()
                            .padding(.horizontal, 12)

                        Button(action: {
                            withAnimation(.spring(response: 0.3)) { isExpanded = false }
                            onMenu()
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "plus")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("tx-1"))
                                Text("Додати вручну")
                                    .font(.body)
                                    .foregroundColor(Color("tx-1"))
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                        }
                    }
                    .frame(width: 220)
                    .background(Color("bg-1"))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 4)
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 0.85, anchor: .bottomTrailing)
                                .combined(with: .opacity),
                            removal: .scale(scale: 0.85, anchor: .bottomTrailing)
                                .combined(with: .opacity)
                        )
                    )
                }

                // FAB кнопка
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                        isExpanded.toggle()
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color("accent"))
                            .frame(width: 56, height: 56)
                            .shadow(color: Color("accent").opacity(0.35), radius: 10, y: 4)

                        Image(systemName: isExpanded ? "xmark" : "mic.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("bg-1"))
                            .rotationEffect(.degrees(isExpanded ? 90 : 0))
                            .scaleEffect(isExpanded ? 0.9 : 1.0)
                    }
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 90)
        }
    }
}


import SwiftUI

struct CustomInputField: View {
    // Вхідні дані для налаштування поля
    let title: String
    let iconName: String
    let placeholder: String
    @Binding var text: String
    
    // Додаткові параметри з дефолтними значеннями
    var isPassword: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    
    // Стан для відображення/приховування пароля
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Заголовок над полем
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color("tx-3"))
                .padding(.horizontal, 5)
            
            // Саме поле з іконками
            HStack(spacing: 12) {
                Image(systemName: iconName)
                    .foregroundColor(Color("tx-3"))
                
                Group {
                    // Якщо це пароль і він прихований
                    if isPassword && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                    } else {
                        // Якщо це звичайне текст або видимий пароль
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                            .autocapitalization(isPassword || keyboardType == .emailAddress ? .none : .sentences)
                            .autocorrectionDisabled(isPassword || keyboardType == .emailAddress)
                    }
                }
                .textContentType(textContentType)
                .foregroundColor(.primary)
                .tint(.primary)
                .accentColor(.primary)
                
                // Кнопка "Око", якщо це поле для пароля
                if isPassword {
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(Color("tx-3"))
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.separator), lineWidth: 0.5)
            )
        }
    }
}

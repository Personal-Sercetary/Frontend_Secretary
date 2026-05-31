import SwiftUI

enum FilterTab: String, CaseIterable {
    case all = "Всі"
    case professional = "Професійні"
    case personal = "Особисті"
}

struct FilterTabsView: View {
    @Binding var selected: FilterTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(FilterTab.allCases, id: \.self) { tab in
                Button(action: { selected = tab }) {
                    Text(tab.rawValue)
                        .font(.subheadline)
                        .fontWeight(selected == tab ? .semibold : .regular)
                        .foregroundColor(selected == tab ? Color("tx-1") : Color("tx-3"))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            selected == tab
                                ? Color("bg-2")
                                : Color.clear
                        )
                        .cornerRadius(20)
                }
            }
        }
        .padding(4)
        .background(Color("bg-3"))
        .cornerRadius(24)
    }
}

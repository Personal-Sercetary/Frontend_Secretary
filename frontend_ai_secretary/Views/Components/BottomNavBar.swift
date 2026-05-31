import SwiftUI

enum Tab {
    case home, schedule, settings
}

struct BottomNavBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarIcon(
                iconName: "house",
                label: "Home",
                isSelected: selectedTab == .home
            ) { selectedTab = .home }
            
            Spacer()
            
            TabBarIcon(
                iconName: "calendar",
                label: "Schedule",
                isSelected: selectedTab == .schedule
            ) { selectedTab = .schedule }
            
            Spacer()
            
            TabBarIcon(
                iconName: "gearshape",
                label: "Settings",
                isSelected: selectedTab == .settings
            ) { selectedTab = .settings }
        }
        .padding(.horizontal, 40)
        .padding(.top, 12)
        .padding(.bottom, 20)
        .background(Color("bg-2"))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.separator)),
            alignment: .top
        )
    }
}

struct TabBarIcon: View {
    let iconName: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? iconName + ".fill" : iconName)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color("tx-1") : Color("tx-3"))
                
                Text(label)
                    .font(.caption2)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? Color("tx-1") : Color("tx-3"))
            }
            .frame(width: 60)
        }
    }
}

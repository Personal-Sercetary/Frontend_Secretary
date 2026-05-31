import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("bg-1")
                .ignoresSafeArea()
            
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .schedule:
                    Text("Schedule")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .settings:
                    Text("Settings")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            BottomNavBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}
#Preview {
    MainTabView()
}

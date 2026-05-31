import SwiftUI

struct HomeView: View {
    @State private var selectedFilter: FilterTab = .all
    @State private var tasks = TaskModel.mockTasks
    @State private var isFABExpanded: Bool = false

    var filteredTasks: [TaskModel] {
        switch selectedFilter {
        case .all: return tasks
        case .professional: return tasks.filter { $0.type == .professional }
        case .personal: return tasks.filter { $0.type == .personal }
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color("bg-1").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {

                    // HEADER
                    HStack(alignment: .center) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color("tx-3"))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Good morning")
                                .font(.subheadline)
                                .foregroundColor(Color("tx-3"))
                            Text("John Doe")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("tx-1"))
                        }

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "bell")
                                .font(.system(size: 18))
                                .foregroundColor(Color("tx-1"))
                                .padding(10)
                                .background(Color("bg-2"))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("bd-1"), lineWidth: 1))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    // OCCUPANCY CARD
                    OccupancyCardView()
                        .padding(.horizontal)

                    // FILTER TABS
                    FilterTabsView(selected: $selectedFilter)
                        .padding(.horizontal)

                    // TASKS HEADER
                    HStack {
                        Text("Daily Tasks")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("tx-1"))
                        Spacer()
                        Button("View all") {}
                            .font(.subheadline)
                            .foregroundColor(Color("tx-3"))
                    }
                    .padding(.horizontal)

                    // TASK CARDS
                    VStack(spacing: 12) {
                        ForEach(filteredTasks) { task in
                            TaskCardView(task: task)
                        }
                    }
                    .padding(.horizontal)

                    // AI OPTIMIZATION BANNER
                    AIOptimizationBanner()
                        .padding(.horizontal)

                    Spacer(minLength: 120)
                }
            }

            // FAB з меню
            FABMenuView(
                isExpanded: $isFABExpanded,
                onVoice: {
                    // TODO: запуск голосового вводу
                },
                onMenu: {
                    // TODO: відкрити чат або форму
                }
            )
        }
    }
}

#Preview {
    HomeView()
}

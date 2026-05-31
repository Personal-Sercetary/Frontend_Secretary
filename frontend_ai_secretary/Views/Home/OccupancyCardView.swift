import SwiftUI

struct OccupancyCardView: View {
    let percent: Double = 0.68

    var body: some View {
        HStack(spacing: 20) {
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(Color("accent").opacity(0.15), lineWidth: 10)
                    .frame(width: 80, height: 80)

                Circle()
                    .trim(from: 0, to: percent)
                    .stroke(Color("accent"), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))

                Text("\(Int(percent * 100))%")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("tx-1"))
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Occupancy")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("tx-1"))

                Text("\(Int((1 - percent) * 100))% availability remaining")
                    .font(.subheadline)
                    .foregroundColor(Color("tx-2"))

                // Status Badge
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color("accent"))
                        .frame(width: 7, height: 7)
                    Text("Система активна")
                        .font(.caption)
                        .foregroundColor(Color("tx-2"))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color("bg-3"))
                .cornerRadius(20)
            }

            Spacer()
        }
        .padding(20)
        .background(Color("bg-2"))
        .cornerRadius(20)
    }
}

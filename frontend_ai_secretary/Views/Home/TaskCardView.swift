import SwiftUI

struct TaskCardView: View {
    let task: TaskModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Top row: progress bar + time
            HStack {
                // Progress indicator (colored pill)
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("accent").opacity(0.6))
                    .frame(width: 60, height: 6)

                Spacer()

                Text(task.timeString)
                    .font(.subheadline)
                    .foregroundColor(Color("tx-2"))
            }

            // Title
            Text(task.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color("tx-1"))

            // Subtitle
            Text(task.subtitle)
                .font(.subheadline)
                .foregroundColor(Color("tx-3"))

            // Bottom badge
            if task.type == .personal {
                HStack(spacing: 6) {
                    Text("ОСОБИСТЕ")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("tx-2"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color("bg-3"))
                        .cornerRadius(6)
                    Spacer()
                    Text(task.timeString)
                        .font(.subheadline)
                        .foregroundColor(Color("tx-2"))
                }
                // Override top time for personal card layout
            }

            Divider()
                .background(Color("bd-1"))

            // Meta info
            HStack(spacing: 4) {
                if let duration = task.duration {
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundColor(Color("tx-3"))
                    Text(duration)
                        .font(.caption)
                        .foregroundColor(Color("tx-3"))
                }
                if let priority = task.priority {
                    Image(systemName: "exclamationmark")
                        .font(.caption)
                        .foregroundColor(Color("accent"))
                    Text(priority)
                        .font(.caption)
                        .foregroundColor(Color("tx-2"))
                }
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

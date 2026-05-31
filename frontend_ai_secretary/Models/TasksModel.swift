import SwiftUI

enum TaskType {
    case professional, personal
}

struct TaskModel: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let timeString: String
    let type: TaskType
    let duration: String?
    let priority: String?
}

extension TaskModel {
    static let mockTasks: [TaskModel] = [
        TaskModel(
            title: "Підготовка до дзвінка",
            subtitle: "Клієнт: Tech Solutions",
            timeString: "9:00 AM",
            type: .professional,
            duration: "1h duration",
            priority: nil
        ),
        TaskModel(
            title: "Відповісти клієнтам",
            subtitle: "Оновити статус проектів",
            timeString: "11:30 AM",
            type: .personal,
            duration: nil,
            priority: "High Priority"
        )
    ]
}

//
//  TaskGroupDetailView.swift
//  ProjectToDo
//
//  Created by Jay Chestnut on 4/13/26.
//

import SwiftUI


struct TaskGroupDetailView: View {
    @Binding var groups: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            Section{
                if sizeClass == .regular {
                    GroupStatsView(tasks: groups.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.systemGroupedBackground))
                }
            }
            ForEach($groups.tasks) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .cyan : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                }
            }
            .onDelete { index in
                groups.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(groups.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    groups.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}

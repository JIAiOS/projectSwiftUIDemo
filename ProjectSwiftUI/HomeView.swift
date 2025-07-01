//
//  HomeView.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/6/30.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(
        entity: Student.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Student.name, ascending: true)]
    ) private var students: FetchedResults<Student>
        
    var body: some View {
        VStack {
            List {
                ForEach(students) { student in
                    HStack {
                        Text(student.name ?? "未知姓名")
                        Spacer()
                        Text("\(student.age)岁")
                        Text(student.sex ? "男" : "女")
                            .foregroundStyle(student.sex ? .blue : .pink)
                    }
                    .padding(.vertical, 8)
                }
            }
            HStack(spacing: 20) {
                // 增按钮
                OperationButton(
                    title: "增",
                    color: .green,
                    action: handleAdd
                )
                
                // 删按钮
                OperationButton(
                    title: "删",
                    color: .red,
                    action: handleDelete
                )
                
                // 改按钮
                OperationButton(
                    title: "改",
                    color: .blue,
                    action: handleUpdate
                )
                
                // 查按钮
                OperationButton(
                    title: "查",
                    color: .orange,
                    action: handleQuery
                )
            }
            .padding()
        }
    }
    
    // MARK: - 按钮操作
    private func handleAdd() {
        print("操作触发--增")
        let studentNames = ["张三", "李四", "王五", "赵六", "钱七"]
        let randomName = studentNames.randomElement()!
        let randomAge = Int16.random(in: 18...25)
        let randomSex = Bool.random()
        
        CoreDataManager.shared.createStudent(name: randomName, age: randomAge, sex: randomSex)
    }
    
    private func handleDelete() {
        print("操作触发--删")
        if let lastStudent = students.last {
            CoreDataManager.shared.deleteStudent(student: lastStudent)
        }
    }
    
    private func handleUpdate() {
        print("操作触发--改")
        if let firstStudent = students.first {
            CoreDataManager.shared.updateStudent(student: firstStudent, name: "\(firstStudent.name ?? "学生")-更新", age: firstStudent.age + 1, sex: !firstStudent.sex)
        }
    }
    
    private func handleQuery() {
        print("操作触发--查")
        let fetchedStudents = CoreDataManager.shared.fetchStudent()
        print("学生总数: \(fetchedStudents.count)")
        for student in fetchedStudents {
            print("姓名: \(student.name ?? "未知"), 年龄: \(student.age), 性别: \(student.sex ? "男" : "女")")
        }
    }
    
    
    private func toggleNavigationBarTitle() {
        withAnimation {
            appState.showNavigationBarTitle.toggle()
        }
    }
}

struct OperationButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(color)
                .cornerRadius(12)
                .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 2)
        }
    }
}

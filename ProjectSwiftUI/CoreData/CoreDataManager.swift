//
//  CoreDataManager.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/7/1.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    //CoreData持久化容器
    lazy var persistentContainer: NSPersistentContainer = {
        //name名称和创建的模型文件名一致
        let container = NSPersistentContainer(name: "TestModel")
        //配置存储位置
        let storeDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let storeUrl = storeDirectory.appendingPathComponent("projectName.sqlite")
        print("⚠️ CoreData 存储路径: \(storeUrl.path)")
        
        let description = NSPersistentStoreDescription(url: storeUrl)
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        description.type = NSSQLiteStoreType
        
        // 应用配置
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("持久化存储失败: \(error), \(error.userInfo)")
            } else {
                print("持久化存储成功: \(storeDescription)")
            }
        }
        
        return container
    }()
    
    var content: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - CRUD操作
    
    //创建学生
    func createStudent(name: String, age: Int16, sex: Bool) {
        let student = Student(context: content)
        student.name = name
        student.age = age
        student.sex = sex
        saveContext()
    }
    
    //获取所有学生
    func fetchStudent() -> [Student] {
        let fetchStudent: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            return try content.fetch(fetchStudent)
        } catch {
            print("Fetch students error: \(error)")
            return []
        }
    }
    
    //更新学生
    func updateStudent(student: Student, name: String, age: Int16, sex: Bool) {
        student.name = name
        student.age = age
        student.sex = sex
        saveContext()
    }
    
    //删除学生
    func deleteStudent(student: Student) {
        content.delete(student)
        saveContext()
    }
    
    func deleteAllStudent() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Student.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try content.execute(deleteRequest)
            saveContext()
        } catch {
            print("Delete all students error: \(error)")
        }
    }
    
    
    //保存上下文
    func saveContext() {
        if content.hasChanges {
            do {
                try content.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

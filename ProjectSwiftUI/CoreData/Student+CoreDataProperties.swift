//
//  Student+CoreDataProperties.swift
//  ProjectSwiftUI
//
//  Created by lier on 2025/7/1.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var sex: Bool

}

extension Student : Identifiable {

}

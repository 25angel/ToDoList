//
//  TodoEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Victor Raiko on 25.11.2024.
//
//

import Foundation
import CoreData


extension TodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }

    @NSManaged public var todo: String?
    @NSManaged public var completed: Bool
    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64

}

extension TodoEntity : Identifiable {

}

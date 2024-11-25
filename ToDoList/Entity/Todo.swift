//
//  Todo.swift
//  ToDoList
//
//  Created by Victor Raiko on 23.11.2024.
//

import Foundation

struct TodosResponse: Codable {
    let todos: [Todo]
}

struct Todo: Identifiable, Codable {
    let id: Int
    var todo: String
    var completed: Bool
    let userId: Int
}

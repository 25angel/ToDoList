//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Victor Raiko on 18.11.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            TodoRouter.createModule()
        } }
}

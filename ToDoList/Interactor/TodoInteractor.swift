//
//  TodosInteractor.swift
//  ToDoList
//
//  Created by Victor Raiko on 23.11.2024.
//

import Foundation
import CoreData

protocol TodoInteractorProtocol: AnyObject {
    var presenter: TodoPresenterProtocol? { get set }
    func fetchTodos()
    func toggleTodoCompletion(_ id: Int)
    func deleteTodo(id: Int)
    func saveTodosToCoreData(_ todos: [Todo])
    func updateTodoText(_ id: Int, newText: String)
}

final class TodoInteractor: TodoInteractorProtocol {
    weak var presenter: TodoPresenterProtocol?

    private var todos: [Todo] = []

    func fetchTodos() {
        // Загружаем задачи из Core Data
        todos = loadTodosFromCoreData()
        
        // Если данные есть в Core Data, передаем их в презентер
        if !todos.isEmpty {
            presenter?.didFetchTodos(todos)
        } else {
            // Если в Core Data нет данных, загружаем их из API
            guard let url = URL(string: "https://dummyjson.com/todos") else { return }

            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decodedResponse = try JSONDecoder().decode(TodosResponse.self, from: data)
                    todos = decodedResponse.todos
                    saveTodosToCoreData(todos)
                    presenter?.didFetchTodos(todos)
                } catch {
                    presenter?.didFailToFetchTodos(error.localizedDescription)
                }
            }
        }
    }

    func toggleTodoCompletion(_ id: Int) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].completed.toggle()
            updateTodoCompletionInCoreData(id: id, completed: todos[index].completed)
            presenter?.didFetchTodos(todos)
        }
    }

    func deleteTodo(id: Int) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let entity = try context.fetch(fetchRequest).first {
                context.delete(entity)
                try context.save()
            }
            todos.removeAll { $0.id == id }
            presenter?.didFetchTodos(todos)
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }

    // MARK: - Core Data Methods

    func saveTodosToCoreData(_ todos: [Todo]) {
        let context = CoreDataManager.shared.context

        for todo in todos {
            let entity = TodoEntity(context: context)
            entity.id = Int64(todo.id)
            entity.todo = todo.todo
            entity.completed = todo.completed
            entity.userId = Int64(todo.userId)
        }

        do {
            try context.save()
        } catch {
            print("Failed to save todos to Core Data: \(error)")
        }
    }

    private func loadTodosFromCoreData() -> [Todo] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { entity in
                Todo(
                    id: Int(entity.id),
                    todo: entity.todo ?? "",
                    completed: entity.completed,
                    userId: Int(entity.userId)
                )
            }
        } catch {
            print("Failed to fetch todos from Core Data: \(error)")
            return []
        }
    }

    func updateTodoText(_ id: Int, newText: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let todoEntity = try context.fetch(fetchRequest).first {
                todoEntity.todo = newText
                try context.save()
                presenter?.didFetchTodos(todos) // Обновляем данные
            }
        } catch {
            print("Failed to update todo in Core Data: \(error)")
        }
    }

    private func updateTodoCompletionInCoreData(id: Int, completed: Bool) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let todoEntity = try context.fetch(fetchRequest).first {
                todoEntity.completed = completed
                try context.save()
            }
        } catch {
            print("Failed to update todo completion: \(error)")
        }
    }
}

import Foundation

protocol TodoPresenterProtocol: AnyObject {
    var view: TodoViewProtocol? { get set }
    var interactor: TodoInteractorProtocol? { get set }
    var router: TodoRouterProtocol? { get set }

    var searchText: String { get set }
    var todos: [Todo] { get set }
    var filteredTodos: [Todo] { get }

    func didFetchTodos(_ todos: [Todo])
    func didFailToFetchTodos(_ error: String)
    func fetchTodos()
    func toggleTodoCompletion(_ id: Int)
    func deleteTodo(id: Int)
}

class TodoPresenter: ObservableObject, TodoPresenterProtocol {
    weak var view: TodoViewProtocol?
    var interactor: TodoInteractorProtocol?
    var router: TodoRouterProtocol?

    @Published var searchText: String = ""
    @Published var todos: [Todo] = []
    @Published var isAddingNewTodo: Bool = false

    var filteredTodos: [Todo] {
        if searchText.isEmpty {
            return todos
        } else {
            return todos.filter { $0.todo.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchTodos() {
        interactor?.fetchTodos()
    }

    func toggleTodoCompletion(_ id: Int) {
        interactor?.toggleTodoCompletion(id)
    }

    func deleteTodo(id: Int) {
        interactor?.deleteTodo(id: id)
    }

    func addNewTodo() {
        isAddingNewTodo = true
    }

    func addNewTodo(with text: String) {
        let newTodo = Todo(id: (todos.last?.id ?? 0) + 1, todo: text, completed: false, userId: 1)
        todos.append(newTodo)  // Добавляем в локальный массив
        interactor?.saveTodosToCoreData([newTodo])  // Сохраняем в Core Data
        
        // Сразу обновляем задачи
        fetchTodos()
    }

    func didFetchTodos(_ todos: [Todo]) {
        DispatchQueue.main.async {
            self.todos = todos
        }
    }

    func didFailToFetchTodos(_ error: String) {
        print("Error: \(error)")
    }

    func showAddTodoModal() {
        isAddingNewTodo = true
    }

    // Метод для обновления текста задачи
    func updateTodoText(_ id: Int, newText: String) {
        interactor?.updateTodoText(id, newText: newText)
    }
}

import SwiftUI

struct TodoListView: View {
    var todos: [Todo]
    var presenter: TodoPresenter
    @Binding var selectedTodoForEditing: Todo?
    @Binding var isEditingTodo: Bool
    
    var body: some View {
        if todos.isEmpty {
            VStack {
                Image(systemName: "tray")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                Text("No tasks found")
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
        } else {
            List {
                ForEach(todos, id: \.id) { todo in
                    TodoRowView(todo: todo, presenter: presenter, selectedTodoForEditing: $selectedTodoForEditing, isEditingTodo: $isEditingTodo)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
    }
}

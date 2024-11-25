
import SwiftUI

struct TodoRowView: View {
    var todo: Todo
    var presenter: TodoPresenter
    @Binding var selectedTodoForEditing: Todo?
    @Binding var isEditingTodo: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                presenter.toggleTodoCompletion(todo.id)
            }) {
                Image(todo.completed ? "circle" : "circleIcon") // Ваши изображения из ассетов
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 48) // Размер кружка
            }
            .buttonStyle(BorderlessButtonStyle())

            ZStack {
                NavigationLink(destination: TodoDetailView(presenter: presenter, todo: todo)) {
                    EmptyView()
                }
                .opacity(0) // Скрываем NavigationLink

                Text(todo.todo)
                    .strikethrough(todo.completed, color: .gray)
                    .foregroundColor(todo.completed ? .gray : .white)
                    .frame(maxWidth: .infinity, alignment: .leading) // Выровнять текст слева
                    .padding(.leading, 8) // Отступ между кружком и текстом
            }
        }
        .contextMenu {
            Button(action: {
                selectedTodoForEditing = todo
                isEditingTodo = true
            }) {
                HStack {
                    Image("edit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Редактировать")
                        .foregroundColor(.white)
                }
            }

            Button(role: .destructive, action: {
                presenter.deleteTodo(id: todo.id)
            }) {
                HStack {
                    Image("trash") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Удалить")
                        .foregroundColor(.white)
                }
            }
        }
        .swipeActions {
            Button(role: .destructive) {
                presenter.deleteTodo(id: todo.id)
            } label: {
                Label("Удалить", systemImage: "trash")
            }
        }
    }
}

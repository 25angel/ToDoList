//
//  TodoContentView.swift
//  ToDoList
//
//  Created by Victor Raiko on 23.11.2024.
//

import SwiftUI

protocol TodoViewProtocol: AnyObject {}

struct TodoContentView: View {
    @ObservedObject var presenter: TodoPresenter
    @State private var selectedTodoForEditing: Todo?
    @State private var isEditingTodo: Bool = false   

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                SearchBar(searchText: $presenter.searchText)
                
                TodoListView(
                    todos: presenter.filteredTodos,
                    presenter: presenter,
                    selectedTodoForEditing: $selectedTodoForEditing,
                    isEditingTodo: $isEditingTodo
                )
                
                FooterView(
                    completedCount: presenter.todos.filter { $0.completed }.count,
                    onAddNewTodo: {
                        presenter.showAddTodoModal()
                    }
                )
            }
            .background(Color(red: 4 / 255, green: 4 / 255, blue: 4 / 255, opacity: 1.0).edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
            .onAppear {
                presenter.fetchTodos()
            }
            .sheet(isPresented: $presenter.isAddingNewTodo) {
                AddTodoView { newTodoText in
                    presenter.addNewTodo(with: newTodoText)
                }
            }
            .background(
                NavigationLink(
                    destination: Group {
                        if let todo = selectedTodoForEditing {
                            TodoDetailView(presenter: presenter, todo: todo)
                        }
                    },
                    isActive: $isEditingTodo,
                    label: { EmptyView() }
                )
                .hidden()
            )
        }
    }
}

struct TodoContentView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = TodoInteractor()
        let presenter = TodoPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor

        return TodoContentView(presenter: presenter)
    }
}

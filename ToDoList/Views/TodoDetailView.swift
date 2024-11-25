//
//  TodoDetailView.swift
//
//  Created by Victor Raiko on 25.11.2024.
//

import SwiftUI

struct TodoDetailView: View {
    @ObservedObject var presenter: TodoPresenter
    @State private var todoText: String
    let todo: Todo

    @Environment(\.presentationMode) var presentationMode

    init(presenter: TodoPresenter, todo: Todo) {
        self.presenter = presenter
        self.todo = todo
        _todoText = State(initialValue: todo.todo)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                TextEditor(text: $todoText)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(8)
            }
            .frame(minHeight: 300)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3)

        }
        .padding()
        .background(
            Color(red: 4 / 255, green: 4 / 255, blue: 4 / 255, opacity: 1.0)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    if todoText != todo.todo {
                        presenter.updateTodoText(todo.id, newText: todoText)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


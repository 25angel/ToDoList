//
//  AddTodoVIew.swift
//  ToDoList
//
//  Created by Victor Raiko on 25.11.2024.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newTodoText: String = ""
    var onAdd: (String) -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextField("Введите задачу", text: $newTodoText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .background(Color(.systemGray5))
                    .foregroundColor(.black) 
                    .cornerRadius(8)
                    .padding()
                    
                Spacer()
            }
            .navigationTitle("Новая задача")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        if !newTodoText.isEmpty {
                            onAdd(newTodoText)
                            dismiss()
                        }
                    }
                }
            }
            .background(Color(red: 4 / 255, green: 4 / 255, blue: 4 / 255, opacity: 1.0))
            
        }
    }
}

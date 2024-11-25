//
//  FooterView.swift
//  FooterView
//
//  Created by Victor Raiko on 23.11.2024.
//

import SwiftUI

struct FooterView: View {
    let completedCount: Int
    var onAddNewTodo: () -> Void

    var body: some View {
        HStack {
            Spacer()

            Text("\(completedCount) Задач")
                .font(.callout)
                .foregroundColor(.white)

            Spacer()

            Button(action: {
                onAddNewTodo()
            }) {
                Image("update") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color(red: 39 / 255, green: 39 / 255, blue: 41 / 255, opacity: 1.0))
    }
}

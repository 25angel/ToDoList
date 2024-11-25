//
//  HeaderView.swift
//  ToDoList
//
//  Created by Victor Raiko on 23.11.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Задачи")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top)
    }
    
}


#Preview {
    HeaderView()
}

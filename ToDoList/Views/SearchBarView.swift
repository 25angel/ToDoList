//
//  SearchBarView.swift
//  ToDoList
//
//  Created by Victor Raiko on 23.11.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .foregroundColor(.black)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                )
        }
        .padding(.horizontal)
    }
}

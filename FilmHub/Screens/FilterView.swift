//
//  FilterView.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 16.05.2024.
//

import SwiftUI


struct FilterView: View {
    
    @Binding var isFiltering: Bool
    
    init(isFiltering: Binding<Bool>) {
        self._isFiltering = isFiltering
    }
    var body: some View {
        Text("fdfd")
    }
}

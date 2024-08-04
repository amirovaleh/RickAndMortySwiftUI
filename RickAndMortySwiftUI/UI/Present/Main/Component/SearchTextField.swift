//
//  SearchTextField.swift
//  SampleProject
//
//  Created by Valeh Amirov on 26.05.24.
//

import SwiftUI

struct SearchTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 18)
            
            TextField("", text: $text, prompt: Text("Search").foregroundStyle(Color.customPurple.opacity(0.5)))
        }
        .padding(12)
        .background(Color.customGray.opacity(0.8))
        .clipShape(.rect(cornerRadius: 12))
        .padding()
    }
}

//
//  ContentView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel(repository: CharacterRepository())
    
    var body: some View {
            List(vm.charactersData) { item in
                Text(item.name ?? "")
            }
        .onAppear {
            vm.fetchData()
        }
    }
}

#Preview {
    MainView()
}

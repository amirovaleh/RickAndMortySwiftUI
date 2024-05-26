//
//  ContentView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel(repository: CharacterRepository())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                GridView(characterItem: vm.charactersData)
            }
            .onAppear {
                vm.fetchData()
            }
        }
    }
}

#Preview {
    MainView()
}


//List(vm.charactersData) { item in
//    let url = URL(string: item.image ?? "")
//    WebImage(url: url)
//}

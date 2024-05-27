//
//  ContentView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel()
    
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchTextField(text: $text)
                    .onChange(of: text) { oldValue, newValue in
                        vm.search(text: newValue)
                    }
                GridView(characterItem: vm.filteredData)
            }
            .background(Color.customPurple)
            .onAppear {
                vm.fetchData()
            }
        }
    }
}

#Preview {
    MainView()
}

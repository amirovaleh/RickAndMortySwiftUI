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
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 15)]
    
    var body: some View {
        ScrollView {
                LazyVGrid(columns: columns , content: {
                    ForEach(vm.charactersData) { item in
                        let url = URL(string: item.image ?? "")
                        VStack {
                            
                            WebImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 20))
                            } placeholder: {
                                EmptyView()
                            }
                            Text(item.name ?? "")
                            Text(item.species ?? "")
                        }
                    }

                })
            }
        .padding(.horizontal)
        .onAppear {
            vm.fetchData()
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

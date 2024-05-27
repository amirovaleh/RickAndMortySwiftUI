//
//  DetailView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 26.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @StateObject var vm = DetailViewModel()
    var id: Int
    var body: some View {
        ZStack {
            Color.customPurple
                .ignoresSafeArea()
            VStack {
                Text(vm.character.name ?? "Can't Found Data")
                    .font(.system(size: 40))
                VStack(alignment: .leading) {
                    let url = URL(string: vm.character.image ?? "")
                    WebImage(url: url) { image in
                        image
                            .image?.resizable()
                            .scaledToFit()
                            .frame(width: 340)
                            .clipShape(.rect(cornerRadius: 25))
                    }
                    
                    Spacer().frame(height: 30)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Status: \(vm.character.status ?? "") ")
                            Text("Gender: \(vm.character.gender ?? "") ")
                            Text("Species: \(vm.character.species ?? "") ")
                            Text("Type: \(vm.character.type ?? "") ")
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    vm.fetchData(id: id)
                }
                .padding(20)
                
            }
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    DetailView(id: 2)
}

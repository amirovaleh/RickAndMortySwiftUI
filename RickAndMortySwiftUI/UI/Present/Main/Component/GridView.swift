//
//  GridView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import SwiftUI
import SDWebImageSwiftUI


struct GridView: View {
 
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 15)]
    
    @Binding var characterItem: [Results]
    
    var body: some View {
        LazyVGrid(columns: columns , content: {
            ForEach(characterItem) { item in
                NavigationLink {
                    DetailView(id: item.id ?? 0)
                } label: {
                    let url = URL(string: item.image ?? "")
                    VStack {
                        ZStack {
                            WebImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 20))
                            } placeholder: {
                                EmptyView()
                            }
                            ZStack {
                                switch item.gender {
                                case "Male" :
                                    Circle().fill(.blue.opacity(0.7)).frame(width: 20)
                                case "Female":
                                    Circle().fill(.red.opacity(0.7)).frame(width: 20)
                                case "unknown":
                                    Circle().fill(.gray.opacity(0.7)).frame(width: 20)
                                default:
                                    Circle().fill(.black.opacity(0.7)).frame(width: 20)
                                }
                            }
                            .offset(CGSize(width: -70, height: -70))
                            
                            Image(systemName: item.isMarked ?? false ? "bookmark.fill" : "bookmark")
                                
                                .resizable()
                                .frame(width: 20,height: 30)
                                .offset(CGSize(width: 65, height: -65))
                                .foregroundStyle(.black)
                        }
                        Text(item.name ?? "")
                        Text(item.species ?? "")
                    }
                    .foregroundStyle(.white)
                }
            }
        })
        .padding(.horizontal)
    }
}

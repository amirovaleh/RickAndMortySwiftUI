//
//  GridView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import SwiftUI
import SDWebImageSwiftUI


struct GridView: View {
    let characterItem: [Results]
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 15)]
    
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

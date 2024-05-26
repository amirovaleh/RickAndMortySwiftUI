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
        .padding(.horizontal)
    }
}

//
//  HeaderView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 27.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeaderView: View {
    var character: Results
    
    var body: some View {
        let url = URL(string: character.image ?? "")
        WebImage(url: url) { image in
            image
                .image?.resizable()
                .scaledToFit()
                .frame(width: 340)
                .clipShape(.rect(cornerRadius: 25))
        }
    }
}

#Preview {
    HeaderView(character: Results(id: nil, name: nil, status: nil, species: nil, type: nil, gender: nil , origin: nil, location: nil, image: nil, episode: nil, url: nil, created: nil, isMarked: false))
}

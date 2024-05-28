//
//  InfoView.swift
//  SampleProject
//
//  Created by Valeh Amirov on 27.05.24.
//

import SwiftUI

struct InfoView: View {
    var character: Results
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status: \(character.status ?? "") ")
            Text("Gender: \(character.gender ?? "") ")
            Text("Species: \(character.species ?? "") ")
            Text("Type: \(character.type ?? "") ")
        }
    }
}

#Preview {
    InfoView(character: Results(id: nil, name: nil, status: nil, species: nil, type: nil, gender: nil , origin: nil, location: nil, image: nil, episode: nil, url: nil, created: nil, isMarked: false))
}

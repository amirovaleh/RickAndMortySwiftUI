//
//  CharacterModel.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import Foundation

struct CharacterModel: Codable {
    var results: [Results]
}
struct CheckModel: Identifiable, Codable, Equatable {
    var id: Int
    var isMarked: Bool = false
}

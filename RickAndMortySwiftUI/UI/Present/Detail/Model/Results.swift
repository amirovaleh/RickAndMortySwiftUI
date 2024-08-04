//
//  Results.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import Foundation

struct Results: Codable, Identifiable {
    
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    var isMarked: Bool?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

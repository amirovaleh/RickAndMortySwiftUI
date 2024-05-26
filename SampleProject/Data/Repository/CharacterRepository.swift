//
//  CharacterRepository.swift
//  SampleProject
//
//  Created by Valeh Amirov on 24.05.24.
//

import Foundation

protocol DICharacterRepository {
    func getCharacter(completion: @escaping(Result<CharacterModel, NetworkError>) -> Void)
    func getID(id: Int, completion: @escaping(Result<Results, NetworkError>) -> Void)
}

class MockCharacterRepository: DICharacterRepository {
    func getCharacter(completion: @escaping (Result<CharacterModel, NetworkError>) -> Void) {
        completion(.success(CharacterModel(results: [Results(id: 1, name: "sa", status: "SASA", species: "SASAS", type: "dad", gender: "FSF", origin: nil, location: nil, image: "", episode: [""] , url: "", created: "")])))
    }
    
    func getID(id: Int, completion: @escaping (Result<Results, NetworkError>) -> Void) {
        completion(.failure(.badParsing))
    }
    
    
    
}

class CharacterRepository: DICharacterRepository {
    
    let httpClient: HTTPClient = .shared
    
    /// getCharacter gives developer all characters
    func getCharacter(completion: @escaping (Result<CharacterModel, NetworkError>) -> Void) {
        httpClient.GET(endPoint: .character) { (data: CharacterModel?, error: NetworkError? )in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
    
    /// getID gives developer single character
    /// - Parameters:
    ///   - id: developer can get single character with ID
    func getID(id: Int,completion: @escaping (Result<Results, NetworkError>) -> Void) {
        httpClient.GET(endPoint: .singleCharacter(id)) { (data: Results?, error: NetworkError?) in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
}

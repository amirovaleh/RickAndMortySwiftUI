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

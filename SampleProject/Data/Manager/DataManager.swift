//
//  DataManager.swift
//  SampleProject
//
//  Created by Valeh Amirov on 29.05.24.
//

import Foundation

final class DataManager {
    
    func encode<T: Encodable>(items: T, completion: @escaping (Result<Data,Error>) -> Void) {
        do {
            let encode = try JSONEncoder().encode(items)
            completion(.success(encode))
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func decode<T: Decodable>(data: Data, model: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        do {
            let decode = try JSONDecoder().decode(model.self, from: data)
            completion(.success(decode))
        }
        catch {
            completion(.failure(error))
        }
    }
}

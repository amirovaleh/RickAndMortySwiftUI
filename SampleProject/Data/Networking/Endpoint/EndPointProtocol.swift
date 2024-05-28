//
//  EndPointProtocol.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var url: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }
}

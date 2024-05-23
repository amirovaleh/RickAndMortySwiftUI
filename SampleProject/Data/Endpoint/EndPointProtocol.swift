//
//  EndPointProtocol.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import Foundation

protocol EndPointProtocol {
    var baseUrl: String { get }
    var url: String { get }
}

extension EndPointProtocol {
    
    var baseUrl: String {
        return "https://dummyjson.com"
    }
}

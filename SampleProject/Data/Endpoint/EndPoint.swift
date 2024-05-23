//
//  EndPoint.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import Foundation

enum EndPoint: EndPointProtocol {
    case main(Users)
    
    var url: String {
        switch self {
        case .main(let users):
            return users.url
        }
    }
}


enum Users: EndPointProtocol {
    case getUsers
    
    var url: String {
        switch self {
        case .getUsers:
            return "\(baseUrl)/user"
        }
    }
}

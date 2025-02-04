//
//  HTTPClient.swift
//  SampleProject
//
//  Created by Valeh Amirov on 23.05.24.
//

import Foundation

final class HTTPClient {
    
    private init() {}
    static let shared = HTTPClient()
    
    /// it is generic function which is  send request to API and return us information
    /// - Parameters:
    ///   - endPoint: gives developer the ability to choose which api to send a request to
    ///   - method: gives deveoper the ability to choose which type of request we want
    ///   - completion: returned generic type information and custom error type
    private func request<T: Decodable>(endPoint: EndPoint, method: HTTPMethod, body: Data?, completion: @escaping(T?, Error?) -> Void) {
        guard let url = URL(string: endPoint.url) else {
            completion(nil, NetworkError.badUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60
        
        if let requestBody = body {
                    urlRequest.httpBody = requestBody
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            self.checkError(error: error, completion: completion)
            self.checkStatus(response: response, data: data, urlRequest: urlRequest, method: method, completion: completion)
        }
        .resume()
    }
    
    func checkError<T: Decodable>(error: Error?, completion: @escaping(T?, Error?) -> Void) {
        if let error {
            completion(nil, NetworkError.unknowned)
            print(error)
            
            if let urlError = error as? URLError {
                if urlError.code == .timedOut {
                    completion(nil, NetworkError.timeOut)
                } else if urlError.code == .badURL {
                    completion(nil, NetworkError.badUrl)
                } else if urlError.code == .notConnectedToInternet {
                    completion(nil, NetworkError.noInternetConnection)
                }
            }
        }
    }
    
    func checkStatus<T: Decodable>(response: URLResponse? , data: Data?, urlRequest: URLRequest, method: HTTPMethod, completion: @escaping(T?, Error?) -> Void) {
        
        if let response = response as? HTTPURLResponse {
            guard response.statusCode == 200 else {
                do {
                    if let httpBody = urlRequest.httpBody {
                        print(try JSONSerialization.jsonObject(with: httpBody))
                    }
                    print("\(method.rawValue)", response)
                    
                    guard let data = data else { return }
                    if let result = String(data: data, encoding: .utf8) {
                        print(result)
                    }
                    
                    let errorDecode = try JSONDecoder().decode(ErrorModel.self, from: data)
                    
                    switch response.statusCode {
                    case 400:
                        completion(nil, NetworkError.badRequest(errorDecode.message))
                    case 401...403:
                        completion(nil, NetworkError.unauthorization)
                    case 404:
                        completion(nil, NetworkError.notFound(errorDecode.message))
                    case 500:
                        completion(nil, NetworkError.unknowned)
                    default:
                        completion(nil, NetworkError.statusError)
                    }
                }
                catch {
                    print(error)
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                completion(decode, nil)
            }
            catch {
                self.decodingError(error: error)
                completion(nil, NetworkError.badParsing)
            }
        }
    }
    
    /// When developer use decode and got error it will check developer's error
    private func decodingError(error: Error) {
        if let decodingError = error as? DecodingError {
            switch decodingError {
            case .dataCorrupted(let context):
                print("Data Corrupted: \(context)")
            case .keyNotFound(let key, let context):
                print("Key '\(key.stringValue)' not found:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type mismatch for type '\(type)',", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .valueNotFound(let type, let context):
                print("Value not found for type '\(type)',", context.debugDescription)
                print("CodingPath:", context.codingPath)
            default:
                print("Decoding error:", error)
            }
        } else {
            print("Decoding error:", error)
        }
    }
}

extension HTTPClient {
    func GET<T>(endPoint: EndPoint, completion: @escaping(T?, Error?) -> Void) where T : Decodable {
        self.request(endPoint: endPoint, method: .GET, body: nil) { (data: T?, error: Error?) in
            if let err = error as? NetworkError {
                completion(nil, err)
                return
            }
            
            if let result = data {
                completion(result, nil)
            }
        }
    }
}

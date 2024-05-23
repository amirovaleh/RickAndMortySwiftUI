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
    
    private func resqust<T: Decodable>(endPoint: EndPoint, method: HTTPMethod, body: Any?,/* isToken: Bool,*/ completion: @escaping(T?, NetworkError?) -> Void) {
        guard let url = URL(string: endPoint.url) else {
            completion(nil, .badUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60
        
        if let requestBody = body {
            
            do {
                if let data = requestBody as? Data {
                    urlRequest.httpBody = data
                } else {
                    let json = try JSONSerialization.data(withJSONObject: requestBody)
                    urlRequest.httpBody = json
                }
            }
            catch {
                print(error)
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(nil, .unknowned)
                print(err)
                
                if let urlError = err as? URLError {
                    if urlError.code == .timedOut {
                        completion(nil, .timeOut)
                    } else if urlError.code == .badURL {
                        completion(nil, .badUrl)
                    } else if urlError.code == .notConnectedToInternet {
                        completion(nil, .noInternetConnection)
                    }
                }
                return
            }
            
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
                            completion(nil, .badRequest(errorDecode.message))
                        case 401...403:
                            completion(nil, .unauthorization)
                        case 404:
                            completion(nil, .notFound(errorDecode.message))
                        case 500:
                            completion(nil, .unknowned)
                        default:
                            completion(nil, .statusError)
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
                    completion(nil, .badParsing)
                }
            }
        }
        .resume()
    }
     
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

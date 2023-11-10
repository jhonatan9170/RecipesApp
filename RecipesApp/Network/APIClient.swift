//
//  APIClient.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


enum APIClientError: Error {
    case badURL
    case networkError
    case decodingError
    case httpError(Int)
}

protocol URLSessionProtocol{
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

protocol APIClientProtocol {
    func request<T: Codable>(
            url: String,
            method: HTTPMethod,
            headers: [String: String]?,
            parameters: [String: Any]?,
            completion: @escaping (Result<T, APIClientError>) -> Void
        )
}

extension URLSession:URLSessionProtocol{
    
}

class APIClient:APIClientProtocol {
    
    static let shared = APIClient()
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Codable>(url:String, method: HTTPMethod,headers: [String: String]? = nil, parameters: [String: Any]? = nil, completion: @escaping (Result<T,APIClientError>) -> Void) {
        
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        headers?.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            if method == .post {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    completion(.failure(.decodingError))
                    return
                }
            }
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.httpError(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.networkError))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}


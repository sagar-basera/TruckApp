//
//  APIManager.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

protocol ServiceProtocol {
    func request<T:Codable>(model: T.Type, reqDescription: RequestDescriptor, completion: @escaping Handler<T>)
}

final class APIManager: ServiceProtocol {
    
    func request<T:Codable>(model: T.Type, reqDescription: RequestDescriptor, completion: @escaping Handler<T>) {
        guard let url = reqDescription.url else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch(let error){
                print(error)
                completion(.failure(.error(error)))
            }
        }
        .resume()
    }
}

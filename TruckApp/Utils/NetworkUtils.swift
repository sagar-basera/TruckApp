//
//  NetworkUtils.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import Foundation

/// HTTP METHODS.
enum HttpMethod: String {
    case get = "GET"
}

protocol RequestDescriptor {
    var path: String {get}
    var baseURl: String {get}
    var url: URL? {get}
    var header: [String: String]? {get}
    var method: HttpMethod {get}
}

/// ERROR HANDLING FOR API.
enum DataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case error(Error?)
}

enum Endpoint {
    case test
}

extension Endpoint: RequestDescriptor {
    var path: String {
        switch self {
        case .test:
            return "test"
        }
    }
    
    var baseURl: String {
        return Constants.baseUrl
    }
    
    var url: URL? {
        return URL(string: "\(baseURl)\(path)")
    }
    
    var header: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    var method: HttpMethod {
        switch self {
        case .test:
            return .get
        }
    }
    
}

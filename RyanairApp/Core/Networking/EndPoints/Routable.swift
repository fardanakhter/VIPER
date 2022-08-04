//
//  Router.swift
//  Dubizzle
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias APIParams = [String: Any]?
typealias APIHeaders = [String: String]

enum EncodingType {
    case urlEncoding
    case jsonEncoding
}

protocol Routable {
    /// baseURL for calling any server
    var baseURLString: String { get }
    
    /// by default method is HTTPMethod.get
    var method: APIMethod { get }
    
    /// path should be appended with baseURL
    var path: String { get }
    var params: APIParams? { get }
    var headers: APIHeaders? { get }
    var parameterEncoding: EncodingType { get }
}

extension Routable {
    
    var baseURLString: String { return
        "https://sit-nativeapps.ryanair.com/api/v4"
    }
}

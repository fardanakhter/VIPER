//
//  BaseAPIClient.swift
//  Dubizzle
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

typealias APIResult<T> = Swift.Result<T, Error>

protocol NetworkInteractor {
    func request<T: Codable>(route: Routable, decoder: JSONDecoder, completion: @escaping((APIResult<T>) -> Void ))
}

class BaseAPIClient: NetworkInteractor {
    
    private let network: NetworkInteractor
    
    init(network: NetworkInteractor = AlamofireClient()) {
        self.network = network
    }
    
    func request<T: Codable>(route: Routable, decoder: JSONDecoder, completion: @escaping((APIResult<T>) -> Void )) {
       
        network.request(
            route: route,
            decoder: decoder,
            completion: completion
        )
    }
}

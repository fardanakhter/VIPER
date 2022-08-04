//
//  SearchFlightService.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - SearchFlightServiceProtocol

protocol SearchFlightServiceProtocol: AnyObject {
    
    func getFlightSearchedResults(with param: APISearchFlightParam, completion: @escaping (APIResult<APISearchFlightListModel>) -> Void)
}

// MARK: - SearchFlightService

class SearchFlightService: BaseAPIClient, SearchFlightServiceProtocol {
    
    func getFlightSearchedResults(with param: APISearchFlightParam,
                                  completion: @escaping (APIResult<APISearchFlightListModel>) -> Void) {
        
        let endpoint = SearchFlightEndpoint.searchFlights(param: param)
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        super.request(route: endpoint, decoder: decoder, completion: completion)
    }
}

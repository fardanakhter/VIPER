//
//  StationListService.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - Station List Service Protocol

protocol StationListServiceProtocol: AnyObject {
    
    func fetchListOfStations(completion: @escaping (APIResult<APIStationListModel>) -> Void)
}

// MARK: - Station List Service

class StationListService: BaseAPIClient, StationListServiceProtocol {
    
    func fetchListOfStations(completion: @escaping (APIResult<APIStationListModel>) -> Void) {
        
        let endpoint = StationListEndpoint.getStationList
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        super.request(route: endpoint, decoder: decoder, completion: completion)
    }
}

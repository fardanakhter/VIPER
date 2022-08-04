//
//  StationListRouter.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - Station List Endpoint

enum StationListEndpoint: Routable {
    
    case getStationList
    
    var baseURLString: String {
        switch self {
        case .getStationList:
            return "https://mobile-testassets-dev.s3.eu-west-1.amazonaws.com"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .getStationList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getStationList:
            return baseURLString + "/stations.json"
        }
    }
    
    var params: APIParams? {
        switch self {
        case .getStationList:
            return nil
        }
    }
    
    var headers: APIHeaders? {
        switch self {
        case .getStationList:
            return ["Content-type": "application/json",
                    "client": "ios"]
        }
    }
    
    var parameterEncoding: EncodingType {
        switch self {
        case .getStationList:
            return .urlEncoding
        }
    }
    
}

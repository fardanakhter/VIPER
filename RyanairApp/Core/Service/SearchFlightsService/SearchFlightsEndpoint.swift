//
//  SearchFlightsEndpoint.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - StationListEndpoint

enum SearchFlightEndpoint: Routable {
    
    case searchFlights(param: APISearchFlightParam?)
    
    var method: APIMethod {
        switch self {
        case .searchFlights(param: _):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchFlights(param: _):
            return baseURLString + "/Availability"
        }
    }
    
    var params: APIParams? {
        switch self {
        case .searchFlights(param: let filters):
            guard let filters = try? filters?.asDictionary() else { return nil }
            return filters
        }
    }
    
    var headers: APIHeaders? {
        switch self {
        case .searchFlights(param: _):
            return ["Content-type": "application/json",
                    "client": "ios"]
        }
    }
    
    var parameterEncoding: EncodingType {
        switch self {
        case .searchFlights(param: _):
            return .urlEncoding
        }
    }
}

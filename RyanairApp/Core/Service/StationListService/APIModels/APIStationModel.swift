//
//  StationModel.swift
//  Ryanair-Test-App
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - APIStationListModel

struct APIStationListModel: Codable {
    
    let stations: [APIStationModel]
}

// MARK: - APIStationModel

struct APIStationModel: Codable {
    
    let code, name: String
    let alternateName: String?
    let alias: [String]
    let countryCode, countryName: String
    let countryGroupCode: String
    let countryGroupName: APICountryGroupNameModel
    let timeZoneCode, latitude, longitude: String
    let mobileBoardingPass: Bool
    let markets: [APIMarketModel]
    let tripCardImageURL: String?
    let airportShopping: Bool?

    enum CodingKeys: String, CodingKey {
        case code, name, alternateName, alias, countryCode, countryName, countryGroupCode, countryGroupName, timeZoneCode, latitude, longitude, mobileBoardingPass, markets
        case tripCardImageURL = "tripCardImageUrl"
        case airportShopping
    }
}

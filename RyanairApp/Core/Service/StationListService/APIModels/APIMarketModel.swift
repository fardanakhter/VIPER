//
//  MarketGroup.swift
//  Ryanair-Test-App
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - APIMarketModel

struct APIMarketModel: Codable {
    
    let code: String
    let group: APIGroupModel?
    let stops: [APIStopModel]?
    let onlyConnecting, pendingApproval, onlyPrintedBoardingPass: Bool?
}

// MARK: - APIGroupModel

enum APIGroupModel: String, Codable {
    case canary = "CANARY"
    case canaryGold = "CANARY_GOLD"
    case city = "CITY"
    case cityGold = "CITY_GOLD"
    case domestic = "DOMESTIC"
    case domesticGold = "DOMESTIC_GOLD"
    case ethnic = "ETHNIC"
    case leisure = "LEISURE"
    case leisureGold = "LEISURE_GOLD"
    case ukp = "UKP"
    case ukpGold = "UKP_GOLD"
}

//
//  StopModel.swift
//  Ryanair-Test-App
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - Stop Model

struct APIStopModel: Codable {
    
    let code: APICodeModel
}

// MARK: - Code Model

enum APICodeModel: String, Codable {
    
    case bgy = "BGY"
    case crl = "CRL"
    case fco = "FCO"
    case opo = "OPO"
    case stn = "STN"
}

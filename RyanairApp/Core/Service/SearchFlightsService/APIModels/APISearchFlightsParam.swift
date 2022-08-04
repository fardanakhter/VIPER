//
//  APISearchFlightsParam.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

// MARK: - APISearchFlightParam

struct APISearchFlightParam: Encodable {
    
    let origin: String?
    let destination: String?
    let datein: String?
    let dateout: String?
    let flexdaysbeforeout: String?
    let flexdaysout: String?
    let flexdaysbeforein: String?
    let flexdaysin: String?
    let adult: Int?
    let teen: Int?
    let children: Int?
    let toUs: String?
    let discount: String?
    
    enum CodingKeys: String, CodingKey {
        case origin, destination, datein, dateout, flexdaysbeforeout, flexdaysout, flexdaysbeforein, flexdaysin
        case adult = "adt"
        case teen
        case children = "chd"
        case toUs
        case discount = "Disc"
    }
}

extension APISearchFlightParam {
    
    init(searchFlightFormEntity: SearchFlightFormEntity) {
        
        self.origin = searchFlightFormEntity.departureStation
        self.destination = searchFlightFormEntity.arrivalStation
        
        let dateDeparture = searchFlightFormEntity.dateDeparture
        self.dateout = dateDeparture == nil ? nil : Date.formatDateToString(dateDeparture!)
        
        let dateArrival = searchFlightFormEntity.dateArrival
        self.datein = dateArrival == nil ? nil :  Date.formatDateToString(dateArrival!)
        
        self.adult = searchFlightFormEntity.adults
        self.teen = searchFlightFormEntity.teens
        self.children = searchFlightFormEntity.childs
        
        self.flexdaysbeforeout = nil
        self.flexdaysout = nil
        self.flexdaysbeforein = nil
        self.flexdaysin = nil
        self.toUs = nil
        self.discount = nil
    }
    
}

//
//  StationEntity.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

class StationEntity: Identifiable, Equatable {
    
    static func == (lhs: StationEntity, rhs: StationEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let name: String?
    let countryCode: String?
    let countryName: String?
    
    var isSelected: Bool = false
    
    internal init(id: String, name: String?, countryCode: String?, countryName: String?) {
        self.id = id
        self.name = name
        self.countryCode = countryCode
        self.countryName = countryName
    }
    
}

extension StationEntity {
    
    convenience init(stationAPIModel: APIStationModel) {
        
        self.init(
            id: stationAPIModel.code,
            name: stationAPIModel.name,
            countryCode: stationAPIModel.countryCode,
            countryName: stationAPIModel.countryName)
    }
}

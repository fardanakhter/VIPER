//
//  StationPickerListViewModel.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation

struct StationPickerListViewModel {
    
    let code: String
    
    let countryCode: String
    let countryName: String
    let stationName: String
    
    let isSelected: Bool = false
}

extension StationPickerListViewModel {
    
    init(stationEntity: StationEntity) {
        
        self.init(code: stationEntity.id ?? "", countryCode: stationEntity.countryCode ?? "",
                  countryName: stationEntity.countryName ?? "", stationName: stationEntity.name ?? "")
    }
}

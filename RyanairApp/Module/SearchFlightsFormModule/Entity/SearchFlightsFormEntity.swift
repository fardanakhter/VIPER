//
//  SearchFlightsFormEntity.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation

class SearchFlightFormEntity {
    
    var departureStation: String?
    var arrivalStation: String?
    
    var dateDeparture: Date?
    var dateArrival: Date?
    
    var adults: Int = 0
    var teens: Int = 0
    var childs: Int = 0
    
    internal init(departureStation: String?, arrivalStation: String?, dateDeparture: Date?, dateArrival: Date?, adults: Int, teens: Int, childs: Int) {
        
        self.departureStation = departureStation
        self.arrivalStation = arrivalStation
        self.dateDeparture = dateDeparture
        self.dateArrival = dateArrival
        self.adults = adults
        self.teens = teens
        self.childs = childs
        
    }
    
    internal init(){}
}

extension SearchFlightFormEntity {
    
    convenience init(viewModel: SearchFlightsFormViewModel) {
        
        let dateDeparture: Date? = Date.formatStringToDate(viewModel.dateDeparture ?? "")
        let dateArrival: Date? = Date.formatStringToDate(viewModel.dateArrival ?? "")
        
        self.init(departureStation: viewModel.departureStation,
                  arrivalStation: viewModel.arrivalStation,
                  dateDeparture: dateDeparture,
                  dateArrival: dateArrival,
                  adults: viewModel.numberOfAdults,
                  teens: viewModel.numberOfTeens,
                  childs: viewModel.numberOfChildrens)
    }
}

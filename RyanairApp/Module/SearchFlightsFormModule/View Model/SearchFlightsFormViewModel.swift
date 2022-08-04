//
//  SearchFlightsFormViewModel.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation

//origin=DUB&destination=STN&
//dateout=2020-08-09&datein=&
//flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=3&
//adt=1&teen=0&chd=0&roundtrip=false&ToUs=AGREED&Disc=0

class SearchFlightsFormViewModel {
    
    var departureStation: String? = nil
    var arrivalStation: String? = nil
    
    var dateDeparture: String? = "Select Date"
    var dateArrival: String? = "Select Date"
    
    var numberOfAdults: Int = 0
    var numberOfTeens: Int = 0
    var numberOfChildrens: Int = 0
    
}

extension SearchFlightsFormViewModel {
    
    convenience init(entity: SearchFlightFormEntity) {
        self.init()
        
        self.departureStation = entity.departureStation
        self.arrivalStation = entity.arrivalStation
        
        if let departureAt = entity.dateDeparture {
            dateDeparture = Date.formatDateToString(departureAt)
        }
        
        if let arrivalAt = entity.dateArrival {
            dateArrival = Date.formatDateToString(arrivalAt)
        }
        
        numberOfAdults = entity.adults
        numberOfTeens = entity.teens
        numberOfChildrens = entity.childs
        
    }
    
}

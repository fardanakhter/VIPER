//
//  SearchFlightFormInteractor.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation
import UIKit
import SwiftUI

class SearchFlightsFormInteractor : SearchFlightsFormInteractorInputProtocol, SearchFlightsFormDataStore {
    
    var presenter: SearchFlightsFormInteractorOutputProtocol?
    
    var service: SearchFlightServiceProtocol
    
    var stationType: StationTypeEntity?

    var searchFlightFormEntity: SearchFlightFormEntity!
    
    init(service: SearchFlightServiceProtocol) {
        self.service = service
        self.searchFlightFormEntity = SearchFlightFormEntity()
    }
    
    func refreshData() {
        presenter?.displayDataToView(with: searchFlightFormEntity)
    }
    
    func searchFlights(with entity: SearchFlightFormEntity) {
     
        let flightSearchResponseHandler = { [weak self] (result : APIResult<APISearchFlightListModel>) in
            
            switch result {
            
            case .success(let responseData):
                let searchResultEntity = SearchFlightResultEntity(apiResponse: responseData)
                self?.presenter?.displaySearchResult(success: searchResultEntity, failure: nil)
                
            case .failure(let error):
                self?.presenter?.displaySearchResult(success: nil, failure: error)
            }
        }
        
        let searchForFlightRequest = APISearchFlightParam(searchFlightFormEntity: entity)
        service.getFlightSearchedResults(with: searchForFlightRequest, completion: flightSearchResponseHandler)
    }
    
    func getEntity(from viewModel: SearchFlightsFormViewModel) -> SearchFlightFormEntity? {
        SearchFlightFormEntity(viewModel: viewModel)
    }
    
    func updateStationSelection(with type: StationTypeEntity) {
        stationType = type
    }
    
}

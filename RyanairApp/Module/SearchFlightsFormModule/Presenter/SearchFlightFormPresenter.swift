//
//  SearchFlightFormPresenter.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation

class SearchFlightFormPresenter: SearchFlightsFormPresenterProtocol {
    
    weak var view: SearchFlightsFormViewProtocol?
    
    var interactor: SearchFlightsFormInteractorInputProtocol?
    
    var router: SearchFlightsFormRouterProtocol?
    
    var viewModel: SearchFlightsFormViewModel?
    
    init(view: SearchFlightsFormViewProtocol, interactor: SearchFlightsFormInteractorInputProtocol, router: SearchFlightsFormRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func refreshData() {
        
        interactor?.refreshData()
        
        guard let viewModel = viewModel else {
            return
        }

        view?.updateViewWith(viewModel: viewModel)
    }
    
    func searchFlights() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        guard let entity = interactor?.getEntity(from: viewModel) else {
            return
        }
        
        interactor?.searchFlights(with: entity)
    }
    
    func pickDepartureStation() {
        interactor?.updateStationSelection(with: .departure)
        router?.routeToStationPicker()
    }
    
    func pickArrivalStation() {
        interactor?.updateStationSelection(with: .arrival)
        router?.routeToStationPicker()
    }
    
}

extension SearchFlightFormPresenter: SearchFlightsFormInteractorOutputProtocol {
    
    func displayDataToView(with data: SearchFlightFormEntity) {
    
        let viewModel = SearchFlightsFormViewModel(entity: data)
        self.viewModel = viewModel
        view?.updateViewWith(viewModel: viewModel)
        
    }
    
    func displaySearchResult(success: SearchFlightResultEntity?, failure: Error?) {
        
        view?.hideActivityIndicator()
        
        if let _ = success {
            // display data
            return
        }
        
        if let _ = failure {
            // display error
            return
        }
    }
}

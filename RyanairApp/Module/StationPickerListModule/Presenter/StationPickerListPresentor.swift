//
//  StationPickListPresentor.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation

typealias StationPikcerListPresenterType = StationPickerListPresenterProtocol & StationPickerListInteractorOutputProtocol

class StationPickerListPresenter: StationPickerListPresenterProtocol {
    
    var selectedViewModel: StationPickerListViewModel?
    
    weak var view: StationPickerListViewProtocol?
    
    var interactor: StationPickerListInteractorInputProtocol?
    
    var router: StationPickerWireframeProtocol?
    
    var listOfStationViewModels: [StationPickerListViewModel]?
    
    init(view: StationPickerListViewProtocol, interactor: StationPickerListInteractorType, router: StationPickerWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getStationList() {
        view?.showActivityIndicator()
        interactor?.fetchAllStations()
    }
    
    func pickStation(_ viewModel: StationPickerListViewModel) {
        interactor?.pickStationWith(code: viewModel.code)
    }
    
    func searchStationsWithCode(_ searchQuery: String) {
        interactor?.filterStationsWithCode(searchQuery)
    }
    
    func searchStationsWithName(_ searchQuery: String) {
        interactor?.filterStationsWithName(searchQuery)
    }
    
    func goBack() {
        router?.routeBackToSearchFlightFormView()
    }
}

extension StationPickerListPresenter: StationPickerListInteractorOutputProtocol {
    
    func displayDataView(with data: [StationEntity]) {
        
        view?.hideActivityIndicator()
        
        let stationViewModels: [StationPickerListViewModel] = {
            data.map{ StationPickerListViewModel(stationEntity: $0) }
        }()
        
        listOfStationViewModels = stationViewModels
        
        view?.loadStationsToView(with: stationViewModels)
    }
    
    func displayErrorView(with error: Error) {
        
        view?.hideActivityIndicator()
        view?.showError(error)
    }
}

//
//  Protocols.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation
import UIKit

// MARK: - View

protocol StationPickerListViewProtocol : UIViewController {
    
    var presenter: StationPickerListPresenterProtocol? { get set }
    
    func showActivityIndicator()
    func hideActivityIndicator()
    
    func showError(_ error: Error)
    
    func loadStationsToView(with viewModel: [StationPickerListViewModel])
    func reloadStationsList()
    
    func setSearchBarText(_ text: String)
}

// MARK: - Presenter

protocol StationPickerListPresenterProtocol : AnyObject {
    
    var view: StationPickerListViewProtocol? { get set }
    var interactor: StationPickerListInteractorInputProtocol? { get set }
    var router: StationPickerWireframeProtocol? { get set }
    
    var listOfStationViewModels: [StationPickerListViewModel]? { get set }
    var selectedViewModel: StationPickerListViewModel? { get set }
    
    func getStationList()
    func pickStation(_ viewModel: StationPickerListViewModel)
    
    func searchStationsWithCode(_ searchQuery: String)
    func searchStationsWithName(_ searchQuery: String)

    func goBack()
}

// MARK: - Interactor

/*Interator -> Presenter*/

protocol StationPickerListInteractorOutputProtocol : AnyObject {
    
    func displayDataView(with data: [StationEntity])
    func displayErrorView(with error: Error)
}

protocol StationPickerListDataStore {
    
    var stationSelectionType: StationTypeEntity? { get set }
    var stationEntityList: [StationEntity]? { get set }
}

/*Presenter -> Interactor*/

protocol StationPickerListInteractorInputProtocol : AnyObject {
    
    var presenter: StationPickerListInteractorOutputProtocol? { get set }
    var service: StationListServiceProtocol { get set }
    
    func fetchAllStations()
    
    func filterStationsWithName(_ name: String)
    func filterStationsWithCode(_ code: String)
    
    func pickStationWith(code: String)
    
    func getEntity(from viewModel: StationPickerListViewModel) -> StationEntity?
}

// MARK: - Wireframe

protocol StationPickerListDataPassing {
    
    var dataStore: StationPickerListDataStore? { get set }
    
    func passDataBackToSearchFlightForm(source: StationPickerListDataStore, destination: inout SearchFlightsFormDataStore)
    
}

protocol StationPickerWireframeProtocol : AnyObject, StationPickerListDataPassing {
    
    func routeBackToSearchFlightFormView()
}

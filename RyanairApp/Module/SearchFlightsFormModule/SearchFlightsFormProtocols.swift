//
//  SearchFlightsFormProtocols.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation
import UIKit

//MARK: - View

protocol SearchFlightsFormViewProtocol : UIViewController {
    
    var presenter: SearchFlightsFormPresenterProtocol? { get set }
    
    func showActivityIndicator()
    func hideActivityIndicator()
    
    func showError(_ error: Error)
    
    func updateViewWith(viewModel: SearchFlightsFormViewModel)

}


//MARK: - Presenter

protocol SearchFlightsFormPresenterProtocol : AnyObject {
    
    var view: SearchFlightsFormViewProtocol? { get set }
    var interactor: SearchFlightsFormInteractorInputProtocol? { get set }
    var router: SearchFlightsFormRouterProtocol? { get set }
    
    var viewModel: SearchFlightsFormViewModel? { get set }
    
    func refreshData()
    
    func searchFlights()
    
    func pickDepartureStation()
    
    func pickArrivalStation()
    
}


//MARK: - Interactor

/*Interator -> Presenter*/

protocol SearchFlightsFormInteractorOutputProtocol : AnyObject {
    
    func displayDataToView(with data: SearchFlightFormEntity)
    
    func displaySearchResult(success: SearchFlightResultEntity?, failure: Error?)
}

protocol SearchFlightsFormDataStore {
    
    var stationType: StationTypeEntity? { get set }
    var searchFlightFormEntity: SearchFlightFormEntity! { get set }
    
}

/*Presenter -> Interactor*/

protocol SearchFlightsFormInteractorInputProtocol : AnyObject {
    
    var presenter: SearchFlightsFormInteractorOutputProtocol? { get set }
    var service: SearchFlightServiceProtocol { get set }

    func refreshData()
    func searchFlights(with entity: SearchFlightFormEntity)
    func getEntity(from viewModel: SearchFlightsFormViewModel) -> SearchFlightFormEntity?
    func updateStationSelection(with type: StationTypeEntity) 
}


// MARK: - Wireframe

protocol SearchFlightsFormDataPassing {
    
    var dataStore: SearchFlightsFormDataStore? { get set }
    
    func passDataToStationPickerList(source: SearchFlightsFormDataStore, destination: inout StationPickerListDataStore)

}

protocol SearchFlightsFormRouterProtocol: AnyObject, SearchFlightsFormDataPassing {
    
    func routeToStationPicker()
    
    func routeToSearchFlightFormResult()
    
}

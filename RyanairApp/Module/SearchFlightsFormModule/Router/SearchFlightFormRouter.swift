//
//  SearchFlightFormRouter.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation
import UIKit

class SearchFlightsFormRouter : SearchFlightsFormRouterProtocol {
    
    private weak var viewController: UIViewController?
    
    var dataStore: SearchFlightsFormDataStore?
    
    init(controller: UIViewController?) {
        self.viewController = controller
    }
    
    static func createModule() -> UIViewController {
        
        let searchFlightFormViewInterface = SearchFlightFormView()
        let loaderViewInterface = SVProgressLoader()

        let service = SearchFlightService()
        
        let viewController = SearchFlightsFormViewController(contentInterface: searchFlightFormViewInterface, loaderInterface: loaderViewInterface)
        
        let interactor: SearchFlightsFormInteractorInputProtocol & SearchFlightsFormDataStore = SearchFlightsFormInteractor(service: service)
        
        var router: SearchFlightsFormRouterProtocol = SearchFlightsFormRouter(controller: viewController)
        router.dataStore = interactor
        
        let presenter = SearchFlightFormPresenter(view: viewController, interactor: interactor, router: router)

        presenter.router = router
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController

    }
    
    func routeToStationPicker() {
        
        guard let sourceDS = dataStore, let stationSelectionType = sourceDS.stationType else {
            return
        }
        
        let destinationRouter = StationPickerListRouter()
        let destinationVC = destinationRouter.createModule(for: stationSelectionType)
        
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)

        guard var destinationDS = destinationRouter.dataStore else {
            return
        }
        
        passDataToStationPickerList(source: sourceDS, destination: &destinationDS)

    }
    
    func routeToSearchFlightFormResult() {
        
    }
    
    func passDataToStationPickerList(source: SearchFlightsFormDataStore, destination: inout StationPickerListDataStore) {
        
        destination.stationSelectionType = source.stationType
    }
    
}

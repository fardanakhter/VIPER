//
//  StationPickerListRouter.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation
import UIKit

class StationPickerListRouter: StationPickerWireframeProtocol {
    
    var dataStore: StationPickerListDataStore?
    
    private weak var viewController: UIViewController?
    
    func createModule(for type: StationTypeEntity) -> UIViewController {
        
        let stationListViewInterface = StationPickerListView()
        let loaderViewInterface = SVProgressLoader()

        let service: StationListService = StationListService()
        
        let viewController: StationPickerListViewProtocol = StationPickerListViewController(contentInterface: stationListViewInterface, loaderInterface: loaderViewInterface)
        
        var interactor: StationPickerListInteractorType = StationPickerListInteractor(service: service)
        interactor.stationSelectionType = type
        
        let router = self
        
        let presenter: StationPikcerListPresenterType = StationPickerListPresenter(view: viewController, interactor: interactor, router: router)
        
        
        router.viewController = viewController
        router.dataStore = interactor
        presenter.router = router
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        self.viewController = viewController
        
        return viewController
    }
    
    func routeBackToSearchFlightFormView() {
        
        viewController?.navigationController?.popViewController(animated: true)

        guard let dataStore = dataStore else {
            return
        }

        let parentVC: SearchFlightsFormViewController!

        if let presentingVC = viewController?.presentingViewController as? SearchFlightsFormViewController {
            parentVC = presentingVC
        }
        else if let pushingVC = viewController?.navigationController?.topViewController as? SearchFlightsFormViewController{
            parentVC = pushingVC
        }
        else {
            return
        }

        guard let destinationVC = parentVC else {
            return
        }

        guard var destinationDataStore = destinationVC.presenter?.router?.dataStore else {
            return
        }
        
        passDataBackToSearchFlightForm(source: dataStore, destination: &destinationDataStore)

    }
    
    func passDataBackToSearchFlightForm(source: StationPickerListDataStore, destination: inout SearchFlightsFormDataStore) {
        
        let selectedStation = source.stationEntityList?.first{ $0.isSelected }
        
        switch source.stationSelectionType {
        
        case .arrival:
            destination.searchFlightFormEntity?.arrivalStation = selectedStation?.name
        
        case .departure:
            destination.searchFlightFormEntity?.departureStation = selectedStation?.name
        
        case .none:
            return
        }

    }
    
}

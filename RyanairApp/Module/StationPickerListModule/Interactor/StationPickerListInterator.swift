//
//  StationPickerListInterator.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 19/07/2022.
//

import Foundation
import UIKit

typealias StationPickerListInteractorType = (StationPickerListInteractorInputProtocol & StationPickerListDataStore)

class StationPickerListInteractor: StationPickerListInteractorInputProtocol, StationPickerListDataStore {
    
    weak var presenter: StationPickerListInteractorOutputProtocol?
    
    var service: StationListServiceProtocol
    
    var stationSelectionType: StationTypeEntity?
    
    var stationEntityList: [StationEntity]?
    
    init(service: StationListServiceProtocol) {
        self.service = service
    }

    func fetchAllStations() {
        
        service.fetchListOfStations {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let stationListModel):
                self.handleFetchStationListSuccess(with: stationListModel)
                
            case .failure(let error):
                self.handleFetchStationListFailure(with: error)
            }
        }
    }
    
    func filterStationsWithName(_ name: String) {
        
        if name.isEmpty {
            presenter?.displayDataView(with: stationEntityList ?? [])
            return
        }
        
        let filteredWithNameStationEntities: [StationEntity]? = {
            stationEntityList?.filter {
                $0.name?.lowercased().contains(name.lowercased()) ?? false
            }
        }()
        
        guard let filtered = filteredWithNameStationEntities else {
            return
        }
        
        presenter?.displayDataView(with: filtered)
    }
    
    func filterStationsWithCode(_ code: String) {
        
        let filteredWithCodeStationEntities: [StationEntity]? = {
            stationEntityList?.filter { $0.id.lowercased() == code.lowercased() }
        }()
        
        guard let filtered = filteredWithCodeStationEntities else {
            return
        }
        
        presenter?.displayDataView(with: filtered)
        
    }
    
    func pickStationWith(code: String) {
        stationEntityList?.forEach {
            $0.isSelected = $0.id == code
        }
    }
    
    func getEntity(from viewModel: StationPickerListViewModel) -> StationEntity? {
        
        let entity: StationEntity? = {
            stationEntityList?.first(where: { $0.id == viewModel.code })
        }()
        
        return entity
    }

}

extension StationPickerListInteractor {
    
    fileprivate func handleFetchStationListFailure(with error: Error) {
        
        presenter?.displayErrorView(with: error)
    }
    
    fileprivate func handleFetchStationListSuccess(with data: APIStationListModel) {
        
        let stationEntities: [StationEntity] = {
            data.stations.map{ StationEntity(stationAPIModel: $0) }
        }()
        
        stationEntityList = stationEntities
        
        presenter?.displayDataView(with: stationEntities)
    }
}

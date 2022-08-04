//
//  StationPickerListDelegateDataSource.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import UIKit

typealias StationPickerListDidSelectStation = (station: StationPickerListViewModel, at: IndexPath)

class StationPickerListDelegateDataSource: NSObject {
    
    private(set) var models: [StationPickerListViewModel] = []
    
    var didSelect: ((StationPickerListDidSelectStation) -> Void)?
    
    func configure(models: [StationPickerListViewModel], didSelect: @escaping ((StationPickerListDidSelectStation) -> Void)) {
        
        self.models = models
        
        self.didSelect = didSelect
    }
}

extension StationPickerListDelegateDataSource: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StationPickerListViewCell.identifier, for: indexPath) as! StationPickerListViewCell

        let viewModel = self.models[indexPath.row]

        cell.setupData(viewModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let station = models[indexPath.row]
        
        var dataToPassInDidSelectAction: StationPickerListDidSelectStation
        dataToPassInDidSelectAction.station = station
        dataToPassInDidSelectAction.at = indexPath
        
        didSelect?(dataToPassInDidSelectAction)
    }
    
}

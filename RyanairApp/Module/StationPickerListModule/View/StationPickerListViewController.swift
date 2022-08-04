//
//  StationPickerViewController.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation
import UIKit

class StationPickerListViewController: UIViewController {
    
    var presenter: StationPickerListPresenterProtocol?
    
    fileprivate var contentInterface: StationPickerListInterfaceView
    
    fileprivate var loaderInterface: ProgressLoaderInterface
    
    fileprivate let stationSearchDelegate = StationSearchBarDelegate()
    
    fileprivate let stationPickerListDelagateDatasource = StationPickerListDelegateDataSource()
    
    init(contentInterface: StationPickerListInterfaceView, loaderInterface: ProgressLoaderInterface) {
        
        self.contentInterface = contentInterface
        
        self.loaderInterface = loaderInterface
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationView()
        setupContentInterface()
        presenter?.getStationList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetNavigationViewIfMovingFromParent()
    }
    
    fileprivate func hideNavigationView() {
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func resetNavigationViewIfMovingFromParent() {
        if isMovingFromParent {
            navigationController?.isNavigationBarHidden = false
        }
    }
    
    fileprivate func setupContentInterface() {

        contentInterface.setupViews()
        contentInterface.setStationSearchBarDelegate(source: stationSearchDelegate)
        contentInterface.setStationListDelegateDataSource(source: stationPickerListDelagateDatasource)
        
        observeStationSearchBar()
        
        self.view = contentInterface
        self.view.backgroundColor = .white
    }
    
    fileprivate func observeStationSearchBar() {
        
        stationSearchDelegate.didTextChange = { [weak self] text in
            
            guard let self = self else {
                return
            }
            
            self.presenter?.searchStationsWithName(text)
            
        }
        
        stationSearchDelegate.didSearchClicked = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.contentInterface.didSearchStation()
        }
    }
    
    fileprivate func observeStationPickerList(action: StationPickerListDidSelectStation) {
        let selectedStation = action.0
        presenter?.pickStation(selectedStation)
        presenter?.goBack()
    }
    
}

extension StationPickerListViewController: StationPickerListViewProtocol {
    
    func showActivityIndicator() {
        loaderInterface.show()
    }
    
    func hideActivityIndicator(){
        loaderInterface.hide()
    }
    
    func showError(_ error: Error) {
        loaderInterface.showError(with: "Failed to fetch results !")
    }
    
    func loadStationsToView(with viewModel: [StationPickerListViewModel]) {
        
        stationPickerListDelagateDatasource.configure(models: viewModel, didSelect: observeStationPickerList)
        contentInterface.reloadStationsList()
    }
    
    func reloadStationsList() {
        contentInterface.reloadStationsList()
    }
    
    func setSearchBarText(_ text: String) {
        contentInterface.setSearchBarText(text)
    }
    
}

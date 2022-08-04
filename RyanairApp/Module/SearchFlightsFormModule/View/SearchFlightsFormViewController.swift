//
//  SearchFlightsFormViewController.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 18/07/2022.
//

import Foundation
import UIKit

class SearchFlightsFormViewController: UIViewController {
    
    var presenter: SearchFlightsFormPresenterProtocol?
    
    fileprivate var contentInterface: SearchFlightFormViewInterfaceView
    
    fileprivate var loaderInterface: ProgressLoaderInterface
    
    init(contentInterface: SearchFlightFormViewInterfaceView, loaderInterface: ProgressLoaderInterface) {
        
        self.contentInterface = contentInterface
        
        self.loaderInterface = loaderInterface
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationView()
        setupContentInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refreshData()
    }
    
    fileprivate func setupNavigationView() {
        title = "Search Flight"
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupContentInterface() {
        contentInterface.layoutViews()
        contentInterface.delegate = self
        self.view = contentInterface
        self.view.backgroundColor = .white
    }
}

// View -> Presenter

extension SearchFlightsFormViewController: SearchFlightFormViewInterfaceDelegate {
    
    func didTapSelectDepartureStation() {
        presenter?.pickDepartureStation()
    }
    
    func didTapSelectArrivalStation() {
        presenter?.pickArrivalStation()
    }
    
    func didTapSelectDepartureDate() {
        
    }
    
    func didTapSelectArrivalDate() {
        
    }
    
    func didChangeInAdultSeatsWith(numberOfSeats: Int) {
        
    }
    
    func didChangeInTeenSeatsWith(numberOfSeats: Int) {
        
    }
    
    func didChangeInChildSeatsWith(numberOfSeats: Int) {
        
    }
    
    func didTapSearch() {
        loaderInterface.show()
        presenter?.searchFlights()
    }
    
}

// Presenter -> View

extension SearchFlightsFormViewController: SearchFlightsFormViewProtocol {
    
    func showActivityIndicator() {
        loaderInterface.show()
    }
    
    func hideActivityIndicator() {
        loaderInterface.hide()
    }
    
    func showError(_ error: Error) {
        loaderInterface.showError(with: "Failed To Search Flights at the moment !")
    }
    
    func updateViewWith(viewModel: SearchFlightsFormViewModel) {
        contentInterface.updateViews(with: viewModel)
    }

}

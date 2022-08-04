//
//  SearchFlightsFormView.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 21/07/2022.
//

import Foundation
import UIKit

typealias SearchFlightFormViewInterfaceView = SearchFlightFormViewInterface & UIView

// Controller -> View

protocol SearchFlightFormViewInterface {
    
    var delegate: SearchFlightFormViewInterfaceDelegate? { get set }
    
    func layoutViews()
    
    func updateViews(with viewModel: SearchFlightsFormViewModel)
}

// View -> Controller
 
protocol SearchFlightFormViewInterfaceDelegate: AnyObject {
    
    func didTapSelectDepartureStation()
    
    func didTapSelectArrivalStation()
    
    func didTapSelectDepartureDate()
    
    func didTapSelectArrivalDate()
    
    func didChangeInAdultSeatsWith(numberOfSeats: Int)
    
    func didChangeInTeenSeatsWith(numberOfSeats: Int)
    
    func didChangeInChildSeatsWith(numberOfSeats: Int)
    
    func didTapSearch()
    
}

class SearchFlightFormView: SearchFlightFormViewInterfaceView {
    
    weak var delegate: SearchFlightFormViewInterfaceDelegate?
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Departure"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        label.textColor = .black
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    lazy var departureStationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Station", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(selectDepartureStation), for: .touchUpInside)
        return button
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Arrival"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        label.textColor = .black
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    lazy var arrivalStationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Station", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(selectArrivalStation), for: .touchUpInside)
        return button
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Departure Date"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var departureDateButton: MyButton = {
        let button = MyButton()
        button.setTitle("Select Date", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.addTarget(self, action: #selector(selectDepartureDate), for: .touchUpInside)
        return button
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Arrival Date"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var arrivalDateButton: MyButton = {
        let button = MyButton()
        button.setTitle("Select Date", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.addTarget(self, action: #selector(selectArrivalDate), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .white
        return stackView
    }()
    
    fileprivate var departureDatePicker: DatePicker?
    fileprivate var arrivalDatePicker: DatePicker?
    
    func layoutViews() {
        
        let departureStationContainerView = UIStackView()
        departureStationContainerView.axis = .vertical
        departureStationContainerView.spacing = 8
        departureStationContainerView.addArrangedSubview(departureTitleLabel)
        departureStationContainerView.addArrangedSubview(departureStationButton)
        
        let arrivalStationContainerView = UIStackView()
        arrivalStationContainerView.axis = .vertical
        arrivalStationContainerView.spacing = 8
        arrivalStationContainerView.addArrangedSubview(arrivalTitleLabel)
        arrivalStationContainerView.addArrangedSubview(arrivalStationButton)
        
        let stationsContainerView = UIStackView()
        stationsContainerView.axis = .horizontal
        stationsContainerView.distribution = .fillEqually
        stationsContainerView.addArrangedSubview(departureStationContainerView)
        stationsContainerView.addArrangedSubview(arrivalStationContainerView)
        stationsContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let departureDateContainerView = UIStackView()
        departureDateContainerView.axis = .vertical
        departureDateContainerView.spacing = 8
        departureDateContainerView.addArrangedSubview(departureDateLabel)
        departureDateContainerView.addArrangedSubview(departureDateButton)
        
        let arrivalDateContainerView = UIStackView()
        arrivalDateContainerView.axis = .vertical
        arrivalDateContainerView.spacing = 8
        arrivalDateContainerView.addArrangedSubview(arrivalDateLabel)
        arrivalDateContainerView.addArrangedSubview(arrivalDateButton)
        
        let dateContainerView = UIStackView()
        dateContainerView.axis = .horizontal
        dateContainerView.distribution = .fillEqually
        dateContainerView.addArrangedSubview(departureDateContainerView)
        dateContainerView.addArrangedSubview(arrivalDateContainerView)
        
        contentView.addArrangedSubview(UIView())
        contentView.addArrangedSubview(stationsContainerView)
        contentView.addArrangedSubview(dateContainerView)
        
        let searchContainer = UIStackView()
        searchContainer.alignment = .center
        searchContainer.backgroundColor = .black
        searchContainer.addArrangedSubview(searchButton)
        
        contentView.addArrangedSubview(searchContainer)
        contentView.addArrangedSubview(UIView())
        
        addSubviewAndPinEdges(contentView)
        
        attachDatePickerToView()

    }
    
    func updateViews(with viewModel: SearchFlightsFormViewModel) {
        
        if let departureStationtitle = viewModel.departureStation?.uppercased() {
            departureStationButton.setTitle(departureStationtitle, for: .normal)
        }
        
        if let arrivalStationtitle = viewModel.arrivalStation?.uppercased() {
            arrivalStationButton.setTitle(arrivalStationtitle, for: .normal)
        }
        
        departureDateButton.setTitle(viewModel.dateDeparture, for: .normal)
        
        arrivalDateButton.setTitle(viewModel.dateArrival, for: .normal)
    }
    
    private func attachDatePickerToView() {
        departureDatePicker = DatePicker(inputView: departureDateButton, delgate: self)
        arrivalDatePicker = DatePicker(inputView: arrivalDateButton, delgate: self)
    }
    
    @objc fileprivate func selectDepartureStation() {
        delegate?.didTapSelectDepartureStation()
    }
    
    @objc fileprivate func selectArrivalStation() {
        delegate?.didTapSelectArrivalStation()
    }
    
    @objc fileprivate func selectDepartureDate() {
        departureDateButton.becomeFirstResponder()
        delegate?.didTapSelectDepartureDate()
    }

    @objc fileprivate func selectArrivalDate() {
        arrivalDateButton.becomeFirstResponder()
        delegate?.didTapSelectArrivalDate()
    }
    
    @objc fileprivate func search() {
        delegate?.didTapSearch()
    }
    
}

extension SearchFlightFormView: DatePickerDelegate {
    
    func datePickerDonePressed(datePicker: DatePicker, selectedDate: Date) {
        if datePicker == departureDatePicker {
            let stringDate = Date.formatDateToString(selectedDate)
            departureDateButton.setTitle(stringDate, for: .normal)
            return
        }
        
        if datePicker == arrivalDatePicker {
            let stringDate = Date.formatDateToString(selectedDate)
            arrivalDateButton.setTitle(stringDate, for: .normal)
            return
        }
    }
}

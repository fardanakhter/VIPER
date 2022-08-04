//
//  StationPickerListView.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import UIKit

typealias StationPickerListInterfaceView = StationPickerListInterface & UIView

protocol StationPickerListInterface {
    
    func setupViews()
    
    func setStationListDelegateDataSource(source: UITableViewDelegate & UITableViewDataSource)
    
    func setStationSearchBarDelegate(source: UISearchBarDelegate)
    
    func reloadStationsList()
    
    func setSearchBarText(_ text: String)
    
    func didSearchStation()
}

class StationPickerListView: StationPickerListInterfaceView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Station"
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let listView = UITableView()
        listView.register(StationPickerListViewCell.self, forCellReuseIdentifier: StationPickerListViewCell.identifier)
        return listView
    }()
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .white
        return stackView
    }()
    
    func setupViews() {
        contentView.addArrangedSubview(searchBar)
        contentView.addArrangedSubview(tableView)
        addSubviewAndPinEdges(contentView)
    }
    
    func setStationListDelegateDataSource(source: UITableViewDataSource & UITableViewDelegate) {
        tableView.delegate = source
        tableView.dataSource = source
    }
    
    func setStationSearchBarDelegate(source: UISearchBarDelegate) {
        searchBar.delegate = source
    }
    
    func reloadStationsList() {
        tableView.reloadData()
    }
    
    func setSearchBarText(_ text: String) {
        searchBar.text = text
    }
    
    func didSearchStation() {
        searchBar.resignFirstResponder()
    }

}

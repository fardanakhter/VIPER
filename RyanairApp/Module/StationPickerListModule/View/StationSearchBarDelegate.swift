//
//  StationSearchBarDelegate.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import UIKit

class StationSearchBarDelegate: NSObject, UISearchBarDelegate {

    var didTextChange: ((String) -> Void)?
    
    var didSearchClicked: (() -> Void)?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        didTextChange?(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didSearchClicked?()
    }
}

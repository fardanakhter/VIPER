//
//  ProgressLoaderView.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import SVProgressHUD

protocol ProgressLoaderInterface {
    
    func show()
    
    func showSuccess(with message: String)
    
    func showError(with message: String)
    
    func hide()
    
}

class SVProgressLoader: ProgressLoaderInterface {
    
    static let shared = SVProgressLoader()
    
    func show() {
        SVProgressHUD.show()
    }
    
    func showSuccess(with message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    func showError(with message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
    
}

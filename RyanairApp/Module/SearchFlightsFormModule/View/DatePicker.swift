//
//  DatePicker.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 25/07/2022.
//

import Foundation
import UIKit

class MyButton: UIButton {

    var myView: UIView? = UIView()
    var toolBarView: UIView? = UIView()
    
    override var inputView: UIView? {
        get {
            myView
        }
        
        set {
            myView = newValue
        }
    }

    override var inputAccessoryView: UIView? {
        get {
            toolBarView
        }
        set {
            toolBarView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool {
       true
    }

}

protocol DatePickerDelegate {
    func datePickerDonePressed(datePicker: DatePicker, selectedDate: Date)
}

class DatePicker: NSObject {
    
    private let datePicker = UIDatePicker()

    let inputView: MyButton
    let delegate: DatePickerDelegate
    
    init(inputView: MyButton, delgate: DatePickerDelegate) {
        self.inputView = inputView
        self.delegate = delgate
        
        super.init()
        
        setupDatePicker()
        setupToolBar()
    }
    
    private func setupDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        inputView.inputView = datePicker
    }
    
    private func setupToolBar() {
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        inputView.inputAccessoryView = toolbar
    }
    
    @objc func donedatePicker() {
        inputView.endEditing(true)
        delegate.datePickerDonePressed(datePicker: self, selectedDate: datePicker.date)
    }
    
    @objc func cancelDatePicker(){
        inputView.endEditing(true)
    }
}
 

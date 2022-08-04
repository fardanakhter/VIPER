//
//  StationPickerListViewCell.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import UIKit

class StationPickerListViewCell: UITableViewCell {
    
    static let identifier = "StationPickerListViewCell"
    
    let stationCodeLabel: UILabel = {
        let label = UILabel()
        let priority = UILayoutPriority(249)
        label.setContentHuggingPriority(priority, for: .horizontal)
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    let stationCounrtyCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    let stationCounrtyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    let stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier:  StationPickerListViewCell.identifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // creating container stack to hold subviews
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.addArrangedSubview(stationCodeLabel)
        
        stackView.addArrangedSubview(stationNameLabel)
        
        let countryStackView = UIStackView()
        countryStackView.alignment = .fill
        countryStackView.distribution = .fill
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        
        countryStackView.addArrangedSubview(stationCounrtyCodeLabel)
        countryStackView.addArrangedSubview(stationCounrtyNameLabel)
        
        stackView.addArrangedSubview(countryStackView)

        // adding constraints for stack
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint
            .activate([
                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
                stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
                stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
        
    }
    
    func setupData(_ viewModel: StationPickerListViewModel) {
        stationCodeLabel.text = viewModel.code
        stationCounrtyCodeLabel.text = viewModel.countryCode
        stationCounrtyNameLabel.text = viewModel.countryName
        stationNameLabel.text = viewModel.stationName
    }
    
}

//
//  UIView+Extension.swift
//  RyanairApp
//
//  Created by Fardan Akhter on 20/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
    struct EdgeConstraint {
        
        enum Edge {
            case top, left, right, bottom
        }
        
        let side: Edge
        let value: CGFloat
    }
    
    func addSubviewAndPinEdges(_ child: UIView, constraint: [EdgeConstraint]) {
        addSubview(child)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        constraint.forEach {
            
            switch $0.side {
                
            case .left:
                child.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: $0.value).isActive = true
            
            case .right:
                child.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: $0.value).isActive = true
                
            case .top:
                child.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: $0.value).isActive = true
            
            case .bottom:
                child.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: $0.value).isActive = true
            }
        }
    }
    
    
    func addSubviewAndPinEdges(_ child: UIView) {
        addSubview(child)
        child.pinEdges(to: self)
    }

    private func pinEdges(to other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

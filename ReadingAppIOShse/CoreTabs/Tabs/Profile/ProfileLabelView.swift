//
//  ProfileLabelView.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import UIKit

class ProfileLabelView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "\"A reader lives a thousand lives before he dies... The man who never reads lives only one.\"\n\nGeorge R.R. Martin"
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

}

// MARK: - Setup Constraints
extension ProfileLabelView {
    private func setupConstraints() {
        self.addSubview(label)
        self.layer.cornerRadius = 20.0
        self.backgroundColor = UIColor(red: 1, green: 0.69803921568, blue: 0.11372549019, alpha: 1)
        
        label.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 15).isActive = true
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
}

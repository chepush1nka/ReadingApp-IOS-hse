//
//  SectionHeader.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 30.11.2022.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
    
    public static let reuseId = "SectionHeader"
    
    public let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customizeElements()
        setupConstraints()
    }
    
    private func customizeElements() {
        title.textColor = .label
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CurrentBookCell.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import UIKit

class CurrentBookCell: UICollectionViewCell {
    public static var reuseId: String = "ActiveChatCell"
    
    private let bookName = UILabel()
    private let authorName = UILabel()
    private let descriptionText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .quaternarySystemFill
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    
    private func setupElements() {
        bookName.translatesAutoresizingMaskIntoConstraints = false
        authorName.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configure(with book: String) {
        let epubExt = EpubExtract()
        epubExt.epubName = book
        
        bookName.text = epubExt.epub?.title
        bookName.numberOfLines = 3
        descriptionText.text = epubExt.epub?.metadata["dc:description"]
        descriptionText.numberOfLines = 0
        descriptionText.alpha = 0.6
        descriptionText.textColor = UIColor(red: 1, green: 0.69803921568, blue: 0.11372549019, alpha: 1)
        authorName.text = epubExt.epub?.author
        authorName.font = UIFont.systemFont(ofSize: 16.0)
        authorName.textColor = .systemGray
        authorName.numberOfLines = 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension CurrentBookCell {
    private func setupConstraints() {
        addSubview(descriptionText)
        addSubview(bookName)
        addSubview(authorName)
        
        descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        descriptionText.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -70).isActive = true
        
        
        authorName.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -35).isActive = true
        authorName.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        bookName.bottomAnchor.constraint(equalTo: authorName.topAnchor, constant: 0).isActive = true
        bookName.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
}

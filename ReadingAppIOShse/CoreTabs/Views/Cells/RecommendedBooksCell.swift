//
//  RecommendedBooksCelll.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import UIKit

class RecommendedBooksCell: UICollectionViewCell {
    public static var reuseId: String = "RecommendedBooksCell"
    
    private let bookImageView = UIImageView()
    private let bookName = UILabel()
    private let authorName = UILabel(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        setupElements()
        setupConstraints()
    }
    
    public func configure(with book: String) {
        let epubExt = EpubExtract()
        epubExt.epubName = book
        
        
        bookName.text = epubExt.epub?.title
        bookName.numberOfLines = 2
        authorName.text = epubExt.epub?.author
        authorName.font = UIFont.systemFont(ofSize: 16.0)
        authorName.textColor = .systemGray
        authorName.numberOfLines = 1
        if let coverPath = epubExt.epub?.coverURL?.path {
            self.bookImageView.image = UIImage(contentsOfFile: coverPath)
        }
    }
    
    private func setupElements() {
        bookName.translatesAutoresizingMaskIntoConstraints = false
        authorName.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension RecommendedBooksCell {
    private func setupConstraints() {
        addSubview(bookImageView)
        addSubview(bookName)
        addSubview(authorName)
        
        bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: self.bounds.width * 1.57037037037).isActive = true
        bookImageView.layer.cornerRadius = 20.0
        bookImageView.clipsToBounds = true

        bookName.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10).isActive = true
        bookName.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor).isActive = true
        bookName.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        
        authorName.topAnchor.constraint(equalTo: bookName.bottomAnchor).isActive = true
        authorName.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor).isActive = true
        authorName.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
    }
}

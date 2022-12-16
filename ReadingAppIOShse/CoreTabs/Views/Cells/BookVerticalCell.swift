//
//  BookVerticalCell.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 29.11.2022.
//

import Foundation
import UIKit

class BookVerticalCell: UICollectionViewCell {
    static var reuseId: String = "ActiveChatCell"
    var book: String = ""
    
    let bookImageView = UIImageView()
    let plusButton = UIButton()
    let bookName = UILabel()
    let authorName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    
    func setupElements() {
        bookName.translatesAutoresizingMaskIntoConstraints = false
        authorName.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with book: String) {
        let epubExt = EpubExtract()
        epubExt.epubName = book
        self.book = book
        
        bookName.text = epubExt.epub?.title
        bookName.numberOfLines = 3
        authorName.text = epubExt.epub?.author
        authorName.font = UIFont.systemFont(ofSize: 16.0)
        authorName.textColor = .systemGray
        authorName.numberOfLines = 2
        plusButton.setImage(UIImage(named: "PlusIcon"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonAction(_:)),
                                for: .touchUpInside)
        if let coverPath = epubExt.epub?.coverURL?.path {
            self.bookImageView.image = UIImage(contentsOfFile: coverPath)
        }
    }
    
    @objc
    func plusButtonAction(_ sender: UIImageView) {
//        var arr = UserDefaults.standard.stringArray(forKey: "epubNameP") ?? [String]()
//        
//        print(arr)
//        if (!arr.contains(book)) {
//            arr.append(book)
//            UserDefaults.standard.set(arr, forKey: "epubName")
//            UserDefaults.standard.synchronize()
//            print(arr)
//        }
        
        //let vc = BookDescriptionSheet()
        //self.window?.rootViewController!.present(vc, animated: true, completion: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension BookVerticalCell {
    func setupConstraints() {
        addSubview(bookImageView)
        addSubview(bookName)
        addSubview(authorName)
        addSubview(plusButton)
        
        // oponentImageView constraints
        bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 92).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        bookImageView.layer.cornerRadius = 10.0
        bookImageView.clipsToBounds = true
        
        // gradientView constraints
        plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 16).isActive  = true
        
        // oponentLabel constraints
        bookName.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        bookName.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 16).isActive = true
        bookName.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 0).isActive = true
        
        // lastMessageLabel constraints
        authorName.topAnchor.constraint(equalTo: bookName.bottomAnchor).isActive = true
        authorName.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 16).isActive = true
        authorName.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -16).isActive = true
    }
}

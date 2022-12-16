//
//  BookDescriptionSheet.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 01.12.2022.
//

import Foundation
import UIKit
//import EpubExtractor

class BookDescriptionSheet: UIViewController, UISheetPresentationControllerDelegate {
    let epubExt = EpubExtract()
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    let closeButton = UIButton(type: .custom)
    let readButton = UIButton(type: .custom)
    let bookImageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let currentPublisherLabel = UILabel()
    let jenreLabel = UILabel()
    let currentJenreLabel = UILabel()
    let languageLabel = UILabel()
    let currentLanguageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func configure(with book: String) {
        epubExt.epubName = book
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupView() {
        setupSheetPresentationController()
        setupNavBar()
        setupConstraints()
        setupInfo()
        setupBackground()
    }
    
    func setupInfo() {
        titleLabel.text = epubExt.epub?.title
        titleLabel.numberOfLines = 5
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 27.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        authorLabel.text = epubExt.epub?.author
        authorLabel.textColor = .black
        authorLabel.font = UIFont.systemFont(ofSize: 17.0)
        authorLabel.numberOfLines = 4
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        jenreLabel.text = "Jenre"
        jenreLabel.textColor = .black
        jenreLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        jenreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        languageLabel.text = "Language"
        languageLabel.textColor = .black
        languageLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        publisherLabel.text = "Publisher"
        publisherLabel.textColor = .black
        publisherLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentPublisherLabel.text = epubExt.epub?.publisher?.capitalized
        currentPublisherLabel.textColor = .black
        currentPublisherLabel.font = UIFont.systemFont(ofSize: 17.0)
        currentPublisherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentJenreLabel.text = epubExt.epub?.metadata["dc:subject"]!.capitalized
        currentJenreLabel.textColor = .black
        currentJenreLabel.font = UIFont.systemFont(ofSize: 17.0)
        currentJenreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentLanguageLabel.text = epubExt.epub?.language?.capitalized
        currentLanguageLabel.textColor = .black
        currentLanguageLabel.font = UIFont.systemFont(ofSize: 17.0)
        currentLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let coverPath = epubExt.epub?.coverURL?.path {
            self.bookImageView.image = UIImage(contentsOfFile: coverPath)
        }
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.layer.cornerRadius = 20.0
        bookImageView.clipsToBounds = true
        
        readButton.backgroundColor = .systemBackground
        readButton.setTitle("Read", for: .normal)
        readButton.setTitleColor(.label, for: .normal)
        readButton.layer.cornerRadius = 20
        readButton.addTarget(self, action: #selector(readButtonAction(_:)),
                              for: .touchUpInside)
        readButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    func readButtonAction(_ sender: UIView) {
        guard let epub = epubExt.epub else { print("no epub"); return }
        //sheetPresentationController.selectedDetentIdentifier = .large
        let vc = TextExtractorViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.epub = epub
        self.present(vc, animated: true)
        
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor(red: 1, green: 0.69803921568, blue: 0.11372549019, alpha: 1)
    }
    
    func setupSheetPresentationController() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.preferredCornerRadius = 20
        sheetPresentationController.detents = [
            .medium()
           // .large(),
        ]
        
    }
    
    private func setupNavBar() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "BackArrow"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
                              for: .touchUpInside)
        
    }
    
    @objc
    func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup Constraints
extension BookDescriptionSheet {
    func setupConstraints() {
        view.addSubview(closeButton)
        view.addSubview(bookImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(readButton)
        view.addSubview(jenreLabel)
        view.addSubview(languageLabel)
        view.addSubview(publisherLabel)
        view.addSubview(currentPublisherLabel)
        view.addSubview(currentJenreLabel)
        view.addSubview(currentLanguageLabel)

        
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive  = true
        
        bookImageView.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 0).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2.5/1.57037037037).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive  = true
        bookImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        
        authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        readButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        readButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        readButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        
        jenreLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        jenreLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor, constant: 0).isActive = true
        
        currentJenreLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        currentJenreLabel.topAnchor.constraint(equalTo: jenreLabel.bottomAnchor, constant: 0).isActive = true
        
        publisherLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        publisherLabel.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor, constant: -10).isActive = true
        
        currentPublisherLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        currentPublisherLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 0).isActive = true
        
        currentLanguageLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        currentLanguageLabel.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 0).isActive = true
        
        languageLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15).isActive = true
        languageLabel.bottomAnchor.constraint(equalTo: currentLanguageLabel.topAnchor, constant: 0).isActive = true
        
    }
}

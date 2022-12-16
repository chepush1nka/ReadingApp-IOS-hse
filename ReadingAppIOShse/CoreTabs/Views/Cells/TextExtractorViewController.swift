//
//  TextExtractorViewController.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import UIKit
import EpubExtractor

class TextExtractorViewController: UIViewController {
    
    private let textView = UITextView()
    private let closeButton = UIButton(type: .close)
    
    var epub: Epub!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTextView()
        setupNavBar()
        setupConstraints()
    }
    
    private func setupTextView() {
        textView.frame = view.frame
        textView.text = extractText()
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupNavBar() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
                              for: .touchUpInside)
        
    }
    
    @objc
    func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func extractText() -> String {
        do {
            return try epub.allContent()
        } catch {
            return "there was an error: \(error)"
        }
    }
}

// MARK: - Setup Constraints
extension TextExtractorViewController {
    private func setupConstraints() {
        view.addSubview(textView)
        view.addSubview(closeButton)
        
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive  = true
        
        textView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -60).isActive = true
    }
}

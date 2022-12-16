//
//  SignInHeaderView.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import UIKit

class SignInHeaderView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "books.vertical"))
        imageView.tintColor = .label
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = ""
        label.textColor = .red
        return label
    }()
    
    private let descript: UILabel = {
        let label = UILabel()
        //label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Read, develop, learn new things and don't forget to put it into practice"
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descript.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

}

extension SignInHeaderView {
    func setupConstraints() {
        self.addSubview(label)
        self.addSubview(imageView)
        self.addSubview(descript)

        
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive  = true
        
        descript.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15).isActive = true
        descript.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        descript.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 15).isActive = true
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
}



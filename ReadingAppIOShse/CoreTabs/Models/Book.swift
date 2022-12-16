//
//  Book.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 29.11.2022.
//

import Foundation

struct Book: Decodable, Hashable {
    let name: String
    let author: String
    let image: String
    let jenre: String
    let release: String
    let language: String
}

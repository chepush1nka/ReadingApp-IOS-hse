//
//  Section.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 29.11.2022.
//

import Foundation

struct Section: Decodable, Hashable {
    let type: String
    let title: String
    var items: [String]
}

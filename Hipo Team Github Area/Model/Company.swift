//
//  Company.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation

struct Company: Decodable {
    let company: String
    let team: String
    let members: [Member]
}

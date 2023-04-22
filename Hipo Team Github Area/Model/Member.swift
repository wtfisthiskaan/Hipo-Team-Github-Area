//
//  Member.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation

struct Member: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let github: String
    let hipo: Hipo
    
    struct Hipo: Decodable {
        let position: String
        let years_in_hipo: Int
    }
}

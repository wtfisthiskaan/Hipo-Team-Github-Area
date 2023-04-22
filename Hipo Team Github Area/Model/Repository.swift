//
//  Repository.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation
struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let updated_at: String
    let language: String?
    let stargazers_count: Int
}

//
//  UserInfo.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 22.04.2023.
//

import Foundation

struct UserInfo: Codable {
    let followers: Int
    let following: Int
    let avatar_url: String
    let public_repos: Int
}

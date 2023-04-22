//
//  MemberJSONModel.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation

class MemberJSONModel: ObservableObject {
    @Published var members: [Member] = []

    init() {
        loadJSONData()
    }

    private func loadJSONData() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            fatalError("Could not find the JSON file.")
        }
        do {
            let data = try Data(contentsOf: url)
            let company = try JSONDecoder().decode(Company.self, from: data)
            self.members = company.members
        } catch {
            print("Error decoding JSON data: \(error)")
        }
    }
}

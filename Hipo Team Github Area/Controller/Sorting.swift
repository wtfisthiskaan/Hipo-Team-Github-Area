//
//  Sorting.swift
//  Hipo Team Github Area
//
//  Created by Kaan Uslu on 21.04.2023.
//

import Foundation

extension String {
    func countOccurrences(of character: Character) -> Int {
        return self.reduce(0) { count, currentCharacter in
            return count + (currentCharacter == character ? 1 : 0)
        }
    }
}

func sort(array: [String], character: Character) -> [String] {
    return array.sorted { string1, string2 in
        let count1 = string1.countOccurrences(of: character)
        let count2 = string2.countOccurrences(of: character)

        if count1 == count2 {
            if string1.count == string2.count {
                return string1 < string2
            } else {
                return string1.count > string2.count
            }
        } else {
            return count1 > count2
        }
    }
}

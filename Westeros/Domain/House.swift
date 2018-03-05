//
//  House.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 16/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person> // Generic

// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
        _members = Members()
    }
}


extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard person.house.name == self.name else {
            return
        }
        _members.insert(person)
    }
}


// MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}


// Mark: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}


// Mark: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}


// Mark: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}


// MARK: - Sigil
final class Sigil {
    let description: String
    let image: UIImage
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}

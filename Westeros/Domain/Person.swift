//
//  Character.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 21/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias : String? // no se ve desde fuera
    
    var alias: String {
//        if let _alias = _alias {
//            // Existe y está en alias
//            return _alias
//        } else {
//            return ""
//        }
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House) { // valor por defecto de alias (si falta es nil). Al hacer esto creamos varios init al mismo tiempo
        self.name = name
        _alias = alias
        self.house = house
    }
    
    // init sin alias (init de conveniecia)
//    init(name: String, house: House) {
//        self.name = name
//        self.house = house
//        _alias = nil
//    }
    
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

// MARK: - Proxies
extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return "\(fullName)"
    }
}

// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue // proxy (Devuelve String que SI que tiene hashValue)
    }
}

// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}





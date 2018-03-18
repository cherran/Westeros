//
//  Season.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 14/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import Foundation


typealias Episodes = Set<Episode> // Generic


// MARK: - Season
final class Season {

    // MARK: - Properties
    let name: String
    let airDate: Date
    private var _episodes: Episodes
    
    init(name: String, airDate: Date) {
        self.name = name
        self.airDate = airDate
        _episodes = Episodes()
    }
}


// MARK: - Episodes List
extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedMembers: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season?.name == self.name else {
            return
        }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {         // persons: [Person]
        episodes.forEach{ add(episode: $0) }
    }
}


// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(airDate) \(count)"
    }
    
    var proxyForComparison: Date {
        return airDate
    }
}


// Mark: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}


// Mark: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}


// Mark: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// Mark: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "MMMM d, y"
        
        let date = dateFormatter.string(from: airDate)
        return "\(name), first aired: \(date). Total episodes: \(count)"
    }
    
    
}



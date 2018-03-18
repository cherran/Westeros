//
//  Episode.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 14/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import Foundation

// MARK: - Episode
final class Episode {
    // MARK - Properties
    let title: String
    let airDate: Date
    weak var season: Season?
    
    // MARK: - Initialization
    init(title: String, airDate: Date, season: Season) {
        self.title = title
        self.airDate = airDate
        self.season = season
    }
}


// MARK: - Proxy
extension Episode {
    var proxyForEquality: String {
        return "\(title) \(airDate) \(season?.name ?? "")"
    }
    
    var proxyForComparison: Date {
        return airDate
    }
}


// Mark: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}


// Mark: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}


// Mark: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}


// MARK: - CustomStringConvertible
extension Episode:CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "MMMM d, y"
        
        let date = dateFormatter.string(from: airDate)
        
        return "\(title), \(season?.name ?? "") . First aired: \(date)."
    }
}





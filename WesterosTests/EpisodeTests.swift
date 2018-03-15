//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Carlos de la Herrán Martín on 14/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    var season1: Season!
    var season2: Season!
    var season3: Season!
    
    var episode1S1: Episode!
    var episode2S1: Episode!
    var episode1S2: Episode!
    var episode2S2: Episode!
    var episode1S3: Episode!
    var episode2S3: Episode!
    
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
    
        dateFormatter.dateFormat = "MMMM d, y"
        
        season1 = Season(name: "Season 1", airDate: dateFormatter.date(from: "April 17, 2011")!);
        season2 = Season(name: "Season 2", airDate: dateFormatter.date(from: "April 1, 2012")!);
        season3 = Season(name: "Season 3", airDate: dateFormatter.date(from: "March 31, 2013")!)
        
        episode1S1 = Episode(title: "Winter Is Coming", airDate: dateFormatter.date(from: "April 17, 2011")!, season: season1)
        episode2S1 = Episode(title: "The Kingsroad", airDate: dateFormatter.date(from: "April 24, 2011")!, season: season1)
        
        episode1S2 = Episode(title: "The North Remembers", airDate: dateFormatter.date(from: "April 1, 2012")!, season: season2)
        episode2S2 = Episode(title: "The Night Lands", airDate: dateFormatter.date(from: "April 8, 2012")!, season: season2)
        
        episode1S3 = Episode(title: "Valar Dohaeris", airDate: dateFormatter.date(from: "March 31, 2013")!, season: season2)
        episode2S3 = Episode(title: "Dark Wings, Dark Words", airDate: dateFormatter.date(from: "April 7, 2013")!, season: season2)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1S1)
        XCTAssertNotNil(episode2S1)
        XCTAssertNotNil(episode1S2)
        XCTAssertNotNil(episode2S2)
        XCTAssertNotNil(episode1S3)
        XCTAssertNotNil(episode2S3)
    }
    
    func testEpisodeEquality() {
        dateFormatter.dateFormat = "MMMM d, y"
        
        // Identidad
        XCTAssertEqual(episode1S1, episode1S1)
        
        // Igualdad
        let equalEpisode = Episode(title: "Winter Is Coming", airDate: dateFormatter.date(from: "April 17, 2011")!, season: season1)
        XCTAssertEqual(episode1S1, equalEpisode)
        
        // Desigualdad
        XCTAssertNotEqual(episode1S1, episode2S2)
    }
    
    func testHashable() {
        XCTAssertNotNil(episode1S1.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(episode1S1, episode2S2)
    }
    
    func testCustomStringConvertible() {
        XCTAssertNotNil(episode1S1.description)
        XCTAssertNotNil(episode1S2.description)
    }
}

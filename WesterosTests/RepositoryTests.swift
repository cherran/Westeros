//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Carlos de la Herrán Martín on 5/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositoryReturnsHouseSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsSeasonSortedArrayOfHouses() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByName() {
        let stark = Repository.local.season(named: "seASOn 1")
        XCTAssertEqual(stark?.name, "Season 1")
        
        let keepcoding = Repository.local.season(named: "stark")
        XCTAssertNil(keepcoding)
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.count == 2 }) // Sintaxis de clausura
        XCTAssertEqual(filtered.count, 7)
        
        let otherFilter = Repository.local.seasons(filteredBy: { $0.name.contains("7") })
        XCTAssertEqual(otherFilter.count, 1)
    }
    
}

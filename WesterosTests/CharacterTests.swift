//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Carlos de la Herrán Martín on 21/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import XCTest

class CharacterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCharacterExistence() {
        let character = Character()
        XCTAssertNotNil(character)
    }
    
}

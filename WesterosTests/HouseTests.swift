//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Carlos de la Herrán Martín on 16/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHouseExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo") // UIImage(): imagen vacía
        let stark = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo") // UIImage(): imagen vacía
        XCTAssertNotNil(starkSigil)
        
        let lannisterSigil = Sigil(image: UIImage(), description: "León Rampante") // UIImage(): imagen vacía
        XCTAssertNotNil(lannisterSigil)
    }
    
}

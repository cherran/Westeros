//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Carlos de la Herrán Martín on 21/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    
    var starkHouse: House! // Variable opcional directamente desempaquetada
    var starkSigil: Sigil! // Esto hay que hacerlo con mucho cuidado
    // Necesitamos que sea opcional en la clase CharacterTests, ya que si los ponemos opcionales Swift nos obliga a que esta clase tenga un inicializador
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCharacterExistence() {
        let ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertNotNil(ned)
        
        let arya = Person(name: "Arya", house: starkHouse)
        XCTAssertNotNil(arya)
    }
    
}

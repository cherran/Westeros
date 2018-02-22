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
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    // Necesitamos que sea opcional en la clase CharacterTests, ya que si los ponemos opcionales Swift nos obliga a que esta clase tenga un inicializador
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo") // UIImage(): imagen vacía
        lannisterSigil = Sigil(image: UIImage(), description: "León Rampante") // UIImage(): imagen vacía
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCharacterExistence() {
        XCTAssertNotNil(robb)
        XCTAssertNotNil(arya)
    }
    
    func testFullName() {
        XCTAssertEqual(robb.fullName, "Robb Stark")
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(tyrion, tyrion)
        
        // Igualdad
        let enano = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        XCTAssertEqual(tyrion, enano)
        
        // Desigualdad
        XCTAssertNotEqual(tyrion, arya)
    }
}




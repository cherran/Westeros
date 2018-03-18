//
//  Repository.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 5/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory() // (Valor por defecto)
}

// MARK: - HouseFactory Protocol
protocol HouseFactory {
    typealias Filter = (House) -> Bool
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

// MARK: - SeasonFactory Protocol
protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    func season(named: String) -> Season?
    func seasons(filteredBy: SeasonFilter) -> [Season]
}


// MARK: - LocalFactory - HouseFactory Implementation
final class LocalFactory: HouseFactory {
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo Huargo") // UIImage(): imagen vacía
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León Rampante") // UIImage(): imagen vacía
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Dragón Tricéfalo")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let arya = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let robb = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first // .first --> el primero que cumpla estos parámetros
        return house
    }
    
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    
    //Crea una función house(:named) , similar a la que acepta un String , pero que sea type safe y funcione el autocompletado.
    //¿Se te ocurre qué tipo de datos podemos utilizar? Haz el test correspondiente.
    // ENUM --> HouseNames
    func house(named name: HouseNames) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.rawValue.uppercased() }.first // .first --> el primero que cumpla estos parámetros
        return house
    }
    
}


// MARK: - LocalFactory - HouseFactory Implementation
extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "MMMM d, y"
        
        let season1 = Season(name: "Season 1", airDate: dateFormatter.date(from: "April 17, 2011")!);
        let season2 = Season(name: "Season 2", airDate: dateFormatter.date(from: "April 1, 2012")!);
        let season3 = Season(name: "Season 3", airDate: dateFormatter.date(from: "March 31, 2013")!)
        let season4 = Season(name: "Season 4", airDate: dateFormatter.date(from: "April 6, 2014")!)
        let season5 = Season(name: "Season 5", airDate: dateFormatter.date(from: "April 12, 2015")!)
        let season6 = Season(name: "Season 6", airDate: dateFormatter.date(from: "April 24, 2016")!)
        let season7 = Season(name: "Season 7", airDate: dateFormatter.date(from: "July 16, 2017")!)
        
        let episode1S1 = Episode(title: "Winter Is Coming", airDate: dateFormatter.date(from: "April 17, 2011")!, season: season1)
        let episode2S1 = Episode(title: "The Kingsroad", airDate: dateFormatter.date(from: "April 24, 2011")!, season: season1)
        
        let episode1S2 = Episode(title: "The North Remembers", airDate: dateFormatter.date(from: "April 1, 2012")!, season: season2)
        let episode2S2 = Episode(title: "The Night Lands", airDate: dateFormatter.date(from: "April 8, 2012")!, season: season2)
        
        let episode1S3 = Episode(title: "Valar Dohaeris", airDate: dateFormatter.date(from: "March 31, 2013")!, season: season3)
        let episode2S3 = Episode(title: "Dark Wings, Dark Words", airDate: dateFormatter.date(from: "April 7, 2013")!, season: season3)
        
        let episode1S4 = Episode(title: "Two Swords", airDate: dateFormatter.date(from: "April 6, 2014")!, season: season4)
        let episode2S4 = Episode(title: "The Lion and the Rose", airDate: dateFormatter.date(from: "April 13, 2014")!, season: season4)
        
        let episode1S5 = Episode(title: "The Wars to Come", airDate: dateFormatter.date(from: "April 12, 2015")!, season: season5)
        let episode2S5 = Episode(title: "The House of Black and White", airDate: dateFormatter.date(from: "April 19, 2015")!, season: season5)
        
        let episode1S6 = Episode(title: "The Red Woman", airDate: dateFormatter.date(from: "April 24, 2016")!, season: season6)
        let episode2S6 = Episode(title: "Home", airDate: dateFormatter.date(from: "May 1, 2016")!, season: season6)
        
        let episode1S7 = Episode(title: "Dragonstone", airDate: dateFormatter.date(from: "July 16, 2017")!, season: season7)
        let episode2S7 = Episode(title: "Stormborn", airDate: dateFormatter.date(from: "July 23, 2017")!, season: season7)
        
        season1.add(episodes: episode1S1, episode2S1)
        season2.add(episodes: episode1S2, episode2S2)
        season3.add(episodes: episode1S3, episode2S3)
        season4.add(episodes: episode1S4, episode2S4)
        season5.add(episodes: episode1S5, episode2S5)
        season6.add(episodes: episode1S6, episode2S6)
        season7.add(episodes: episode1S7, episode2S7)
        
        return [season1, season2, season3, season4, season5, season6, season7]
    }
    
    func season(named: String) -> Season? {
        let season = seasons.filter{ $0.name.uppercased() == named.uppercased() }.first
        return season
    }
    
    func seasons(filteredBy: (Season) -> Bool) -> [Season] {
        return seasons.filter(filteredBy)
    }
    
}



enum HouseNames: String {
    case stark = "Stark"
    case lannister = "Lannister"
    case targaryen = "Targaryen"
    case arryn = "Arryn"
    case tully = "Tully"
    case greyjoy = "Greyjoy"
    case baratheon = "Baratheon"
    case tyrell = "Tyrell"
    case martell = "Martell"
}










//
//  DataStore.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/14/21.
//

import UIKit

struct NewsItem {
    var image: UIImage
    var title: String
    var subtitle: String
    var description: String
}

struct Driver {
    let firstName: String
    let lastName: String
    let team: Team
    let imageUrl: String?
    let description: String? =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"
    let rank: Int = 0
}

struct Team {
    let name: String
    let color: String
    let logoImageUrl: String?
}

enum Teams {
    case mercedes
    case ferrari
    case alpine
    case haas
    case mclaren
    case alpharomeo
    case redbull
    case astonmartin
    case alphatauri
    case williams
}

class DataStore {
    static let shared = DataStore()
    
    func getNewsItems() -> [NewsItem] {
        let newsItems =  [
            NewsItem(image: UIImage(named: "car-1") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description"),
            NewsItem(image: UIImage(named: "car-2") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description"),
            NewsItem(image: UIImage(named: "car-3") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description")
        ]
        return newsItems
    }
    
    func getDriversData() -> [Driver] {
        
        let drivers = [
            Driver(firstName: "Lando", lastName: "Norris", team: getTeamData(for: .mclaren), imageUrl: "norris"),
            Driver(firstName: "Daniel", lastName: "Ricciardo", team: getTeamData(for: .mclaren), imageUrl: "ricciardo"),
            
            Driver(firstName: "Lewis", lastName: "Hamilton", team: getTeamData(for: .mercedes), imageUrl: "hamilton"),
            Driver(firstName: "Valtteri", lastName: "Bottas", team: getTeamData(for: .mercedes), imageUrl: "bottas"),
            
            Driver(firstName: "Charles", lastName: "Leclerc", team: getTeamData(for: .ferrari), imageUrl: "leclerc"),
            Driver(firstName: "Carlos", lastName: "Sainz", team: getTeamData(for: .ferrari), imageUrl: "sainz"),
            
            Driver(firstName: "Fernando", lastName: "Alonso", team: getTeamData(for: .alpine), imageUrl: "alonso"),
            Driver(firstName: "Esteban", lastName: "Ocon", team: getTeamData(for: .alpine), imageUrl: "ocon"),
            
            Driver(firstName: "Nikita", lastName: "Mazepin", team: getTeamData(for: .haas), imageUrl: "mazepin"),
            Driver(firstName: "Mick", lastName: "Schumacher", team: getTeamData(for: .haas), imageUrl: "schumacher"),
            
            Driver(firstName: "Kimi", lastName: "Raikkonen", team: getTeamData(for: .alpharomeo), imageUrl: "raikkonen"),
            Driver(firstName: "Antonio", lastName: "Giovinazzi", team: getTeamData(for: .alpharomeo), imageUrl: "giovinazzi"),
            
            Driver(firstName: "Max", lastName: "Verstappen", team: getTeamData(for: .redbull), imageUrl: "verstappen"),
            Driver(firstName: "Sergio", lastName: "Perez", team: getTeamData(for: .redbull), imageUrl: "perez"),
            
            Driver(firstName: "Sebastian", lastName: "Vettel", team: getTeamData(for: .astonmartin), imageUrl: "vettel"),
            Driver(firstName: "Lance", lastName: "Stroll", team: getTeamData(for: .astonmartin), imageUrl: "stroll"),
            
            Driver(firstName: "Pierre", lastName: "Gasly", team: getTeamData(for: .alphatauri), imageUrl: "gasly"),
            Driver(firstName: "Yuki", lastName: "Tsunoda", team: getTeamData(for: .alphatauri), imageUrl: "tsunoda"),
            
            Driver(firstName: "George", lastName: "Russell", team: getTeamData(for: .williams), imageUrl: "russell"),
            Driver(firstName: "Nicholas", lastName: "Latifi", team: getTeamData(for: .williams), imageUrl: "latifi")
        ]
        
        return drivers
    }
    
    private func getTeamData(for team: Teams) -> Team {
        switch team {
        case .mercedes:
            return Team(name: "Mercedes", color: "", logoImageUrl: "")
        case .ferrari:
            return Team(name: "Ferrari", color: "", logoImageUrl: "")
        case .alpine:
            return Team(name: "Alpine", color: "", logoImageUrl: "")
        case .haas:
            return Team(name: "Haas F1", color: "", logoImageUrl: "")
        case .mclaren:
            return Team(name: "McLaren", color: "", logoImageUrl: "")
        case .alpharomeo:
            return Team(name: "Alpha Romeo", color: "", logoImageUrl: "")
        case .redbull:
            return Team(name: "Redbull Racing", color: "", logoImageUrl: "")
        case .astonmartin:
            return Team(name: "Aston Martin", color: "", logoImageUrl: "")
        case .alphatauri:
            return Team(name: "Alpha Tauri", color: "", logoImageUrl: "")
        case .williams:
            return Team(name: "Williams", color: "", logoImageUrl: "")
        }
        
    }
}

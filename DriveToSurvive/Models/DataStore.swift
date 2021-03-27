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
    let rank: Int
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
            NewsItem(image: UIImage(named: "car-1") ?? UIImage(), title: "FIRST LOOK: Mercedes retain black livery", subtitle: "Mercedes look forward to retain championship in 2021.",
                     description: """
                        Red Bull looked set to shake up the order with some cracking pace in testing and they delivered on that promise in first qualifying session of the year, as Max Verstappen took a sensational pole position, thumping world champion Lewis Hamilton by a staggering 0.388s.

                        Verstappen has marked himself out as the man to beat all weekend in Bahrain, the Dutchman topping the times in all three practice sessions and building on that form by winding up his performance through each segment of qualifying.

                        He pipped Hamilton by 0.023s after the first runs in Q3 and though Hamilton improved on his second timed lap, the chasing Verstappen was going quicker too with purple times in all three sectors to move back ahead for back-to-back pole positions for the first time in his career.

                        Mercedes may have been pipped, but with Valtteri Bottas slotting into third, it confirmed that the Silver Arrows had made big gains from pre-season testing and are very much in the fight with Red Bull for the spoils, as F1 enjoyed a genuine two-team battle for pole position.
                """),
            NewsItem(image: UIImage(named: "car-2") ?? UIImage(), title: "What tyres will the teams have for Bahrain GP?", subtitle: "Pirelli have announced which compounds they will bring to Bahrain.", description: "some text description"),
            NewsItem(image: UIImage(named: "car-3") ?? UIImage(), title: "SEASON PREVIEW: Hopes and fears in 2021", subtitle: "We're taking a look at how 2021 is shaping up for the ten teams on the grid", description: "some text description"),
            NewsItem(image: UIImage(named: "news-4") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description"),
            NewsItem(image: UIImage(named: "news-5") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description"),
            NewsItem(image: UIImage(named: "news-6") ?? UIImage(), title: "Test", subtitle: "subtitle sample here", description: "some text description")
            
        ]
        return newsItems
    }
    
    func getDriversData() -> [Driver] {
        
        let drivers = [
            Driver(firstName: "Lando", lastName: "Norris", team: getTeamData(for: .mclaren), imageUrl: "norris", rank: 8),
            Driver(firstName: "Daniel", lastName: "Ricciardo", team: getTeamData(for: .mclaren), imageUrl: "ricciardo", rank: 5),
            
            Driver(firstName: "Lewis", lastName: "Hamilton", team: getTeamData(for: .mercedes), imageUrl: "hamilton", rank: 1),
            Driver(firstName: "Valtteri", lastName: "Bottas", team: getTeamData(for: .mercedes), imageUrl: "bottas", rank: 2),
            
            Driver(firstName: "Charles", lastName: "Leclerc", team: getTeamData(for: .ferrari), imageUrl: "leclerc", rank: 7),
            Driver(firstName: "Carlos", lastName: "Sainz", team: getTeamData(for: .ferrari), imageUrl: "sainz", rank: 6),
            
            Driver(firstName: "Fernando", lastName: "Alonso", team: getTeamData(for: .alpine), imageUrl: "alonso", rank: 21),
            Driver(firstName: "Esteban", lastName: "Ocon", team: getTeamData(for: .alpine), imageUrl: "ocon", rank: 12),
            
            Driver(firstName: "Nikita", lastName: "Mazepin", team: getTeamData(for: .haas), imageUrl: "mazepin", rank: 21),
            Driver(firstName: "Mick", lastName: "Schumacher", team: getTeamData(for: .haas), imageUrl: "schumacher", rank: 21),
            
            Driver(firstName: "Kimi", lastName: "Raikkonen", team: getTeamData(for: .alpharomeo), imageUrl: "raikkonen", rank: 16),
            Driver(firstName: "Antonio", lastName: "Giovinazzi", team: getTeamData(for: .alpharomeo), imageUrl: "giovinazzi", rank: 17),
            
            Driver(firstName: "Max", lastName: "Verstappen", team: getTeamData(for: .redbull), imageUrl: "verstappen", rank: 3),
            Driver(firstName: "Sergio", lastName: "Perez", team: getTeamData(for: .redbull), imageUrl: "perez", rank: 4),
            
            Driver(firstName: "Sebastian", lastName: "Vettel", team: getTeamData(for: .astonmartin), imageUrl: "vettel", rank: 13),
            Driver(firstName: "Lance", lastName: "Stroll", team: getTeamData(for: .astonmartin), imageUrl: "stroll", rank: 11),
            
            Driver(firstName: "Pierre", lastName: "Gasly", team: getTeamData(for: .alphatauri), imageUrl: "gasly", rank: 10),
            Driver(firstName: "Yuki", lastName: "Tsunoda", team: getTeamData(for: .alphatauri), imageUrl: "tsunoda", rank: 21),
            
            Driver(firstName: "George", lastName: "Russell", team: getTeamData(for: .williams), imageUrl: "russell", rank: 18),
            Driver(firstName: "Nicholas", lastName: "Latifi", team: getTeamData(for: .williams), imageUrl: "latifi", rank: 21)
        ]
        
        return drivers.sorted(by: { $0.rank < $1.rank })
    }
    
    private func getTeamData(for team: Teams) -> Team {
        switch team {
        case .mercedes:
            return Team(name: "Mercedes", color: "00D2BE", logoImageUrl: "")
        case .ferrari:
            return Team(name: "Ferrari", color: "DC0000", logoImageUrl: "")
        case .alpine:
            return Team(name: "Alpine", color: "0090FF", logoImageUrl: "")
        case .haas:
            return Team(name: "Haas F1", color: "787878", logoImageUrl: "")
        case .mclaren:
            return Team(name: "McLaren", color: "FF8700", logoImageUrl: "")
        case .alpharomeo:
            return Team(name: "Alpha Romeo", color: "900000", logoImageUrl: "")
        case .redbull:
            return Team(name: "Redbull Racing", color: "0600EF", logoImageUrl: "")
        case .astonmartin:
            return Team(name: "Aston Martin", color: "006F62", logoImageUrl: "")
        case .alphatauri:
            return Team(name: "Alpha Tauri", color: "2B4562", logoImageUrl: "")
        case .williams:
            return Team(name: "Williams", color: "005AFF", logoImageUrl: "")
        }
        
    }
}

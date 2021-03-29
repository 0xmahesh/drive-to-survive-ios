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
    var description: String?
        =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"
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
            NewsItem(image: UIImage(named:"hamilton-bgp") ?? UIImage(), title: "Hamilton wins epic Bahrain GP by just 0.7s", subtitle: "Lewis Hamilton won a nail-biting season opener, triumphing over Max Verstappen.", description:
"""
Mercedes’ Lewis Hamilton won a nail-biting Bahrain Grand Prix season opener, triumphing over the Red Bull of Max Verstappen in a fantastic duel in the desert that went down to the very last lap of the race, as the second Mercedes of Valtteri Bottas completed the podium.

Starting from the fourth pole position of his career, Verstappen had taken control of the race early on, but lost his advantage when Hamilton was able to undercut the Dutchman into the lead in the first round of pit stops. Following a second stop for both drivers – Verstappen’s coming 10 laps after Hamilton’s – a thrilling finale was set up, Verstappen eating into Hamilton’s lead before attempting a pass on Lap 53 but running too wide and giving the place back.

That would be Verstappen’s last opportunity, with Hamilton able to hold on until the flag to take his 96th career win by less than a second – while Hamilton also passed Michael Schumacher’s record of 5,111 for the most laps led in F1 history.

Behind the duelling lead pair, Bottas finished a distant third after a late stop to successfully gain the fastest lap bonus point, while Lando Norris equalled his result from the 2020 Bahrain Grand Prix with a fantastic drive to fourth for McLaren.

"""
            ),
            
            
            NewsItem(image: UIImage(named: "car-1") ?? UIImage(), title: "FIRST LOOK: Mercedes retain black livery", subtitle: "Mercedes look forward to retain championship in 2021.",
                     description:
"""
Mercedes have unveiled the car they hope will power them to a record-extending eighth consecutive World Championship double in 2021, after pulling the covers off the new W12.

The Silver Arrows have dominated in Formula 1 since the switch to turbo-hybrid engines in 2014, picking up every constructors’ and drivers’ championship since that year, when they ended Red Bull’s four-year winning streak.

And the Brackley-based team are aiming to extend that remarkable run with the car they revealed on Tuesday morning, which is officially called the Mercedes-AMG F1 W12 E Performance.
"""
            ),
            NewsItem(image: UIImage(named: "car-2") ?? UIImage(), title: "What tyres will teams have for Bahrain GP?", subtitle: "Pirelli have announced which compounds they will bring to Bahrain.", description:
"""
Pirelli have announced which compounds they will bring to the 2021 season opener in Bahrain on March 28 – with the C4 tyre in play this weekend.

Formula 1 returns this weekend to kick off a 23-race season, and it's time to talk tyres. Pirelli have brought the same tyre allocation to Bahrain International Circuit that they did for the 2020 Grand Prix, in which both Red Bulls finished on the podium behind Lewis Hamilton.

That means the drivers will each get C2 (hard), C3 (medium) and C4 (soft) tyres this weekend, with a fixed allocation of two hard sets, three medium sets and eight soft sets for each race in 2021. However, Pirelli could alter the selection 15 days before an event if need be.

F1's tyre suppliers made sure to choose the tyre choices well before the first Grand Prix, citing "logistical difficulties caused by the Covid-19 pandemic" for the early announcement.
"""),
            NewsItem(image: UIImage(named: "car-3") ?? UIImage(), title: "SEASON PREVIEW: Hopes and fears in 2021", subtitle: "We're taking a look at how 2021 is shaping up for the ten teams on the grid.", description:
"""
Is this the year that Mercedes face a proper, year-long battle for the championship? That’s the hope of probably not only Red Bull fans but anyone except Mercedes supporters who want to see a true fight to the final race.

Never in the hybrid era has another constructor managed to stay in the title fight until even the final two rounds – be it from a drivers’ or teams’ point of view – but 2021 really could be when that run ends.

At least, that’s what pre-season testing told us. Red Bull had finished 2020 strongly but they picked up where they left off and then some, delivering a car that looked far more stable, consistent and all-round quicker than Mercedes during testing.

We shouldn’t get carried away by results in pre-season, but it’s certainly not a bad thing to be quick and reliable at this point, and that only increases the anticipation for what Red Bull can achieve when racing starts.

They’ve tried to strengthen their driver line-up by bringing in Sergio Perez to replace Alex Albon, adding a race-winner with the intention of backing-up Max Verstappen’s strong results with further points to put the pressure on Mercedes.
"""
            ),
            NewsItem(image: UIImage(named: "news-4") ?? UIImage(), title: "What was the best F1 race of 2019?", subtitle: "In a season made up of 21 GPs, there’s no shortage of action to choose from", description:
"""


What was the best race of 2019? In a season made up of 21 Grands Prix and over 6,000km of glorious F1 lappage, there’s certainly no shortage of action to choose from. But we want to know which Grand Prix you thought was the real creme de la creme this year. Vote for your favourite from the list below – and then stick on the highlights to relive all the excitement.
"""),
            NewsItem(image: UIImage(named: "news-5") ?? UIImage(), title: "F1 2021: Our writers' predictions and hot takes", subtitle: "This weekend the lights go out for the first Grand Prix of the 2021 season", description:
"""
I’m most looking forward to…

Mark Hughes (Special contributor): A Red Bull and a Mercedes pretty much equal so we can finally get the full-on Hamilton vs Verstappen duel we've been waiting for for years.

David Tremayne (Hall of Fame F1 journalist): Seeing whether Red Bull can carry over their form from the end of 2020, when Max dominated in Abu Dhabi, and whether Mercedes can hone the W12’s testing problems. If both answers are affirmative, we could be in for a fantastic season. And the improvement Jost Capito is going to make at Williams.

Will Buxton (F1 digital presenter): Red Bull versus Mercedes and a gloves-off fight for the title in the final year of the current regulations. That, and the world slowly getting back to something that looks like normal and which doesn’t rely on someone sticking a large plastic stick in my face every three days.
"""
            )
            
        ]
        return newsItems
    }
    
    func getDriversData() -> [Driver] {
        
        let drivers = [
            Driver(firstName: "Lando", lastName: "Norris", team: getTeamData(for: .mclaren), imageUrl: "norris", description:
                   """
Lando Norris may not be named after Star Wars rebel Lando Calrissian - his Mum just liked the moniker - but he has flair and fighting spirit in bountiful supply.

McLaren had the British teenager on their books for two years before fast-tracking him into F1’s galaxy of stars in 2019. A firecracker in his junior career, with a penchant for pole positions and wheel-to-wheel tussles, Norris didn’t let them down.

Paired with the highly-rated – and far more experienced – Carlos Sainz, his rookie season was impressive, edging the Spaniard in their head-to-head qualifying battle, scoring points on 11 occasions, and only narrowly missing out on a top-10 championship placing. It was a similar pattern in 2020, with the affable Brit securing a maiden podium and moving up to ninth overall.
""", rank: 8),
            
            Driver(firstName: "Daniel", lastName: "Ricciardo", team: getTeamData(for: .mclaren), imageUrl: "ricciardo", description:
                   """
The self-styled “Honey Badger” is fuzzy on the outside and feisty on the inside. Drivers beware because behind Ricciardo’s laidback persona and big grin is a razor-sharp racer with a bite.

The Australian combines all-out speed with impressive race craft. Never afraid to push to the limits if it means pulling off a pass, Ricciardo is a proven race-winner for Red Bull, capable of consistently finishing at the business end of the championship table.


A regular podium-finisher, Ricciardo has christened the steps around the world with a dousing of Aussie culture – the ‘Shoey’ – as he quaffed champagne from a soggy racing boot. Yes it’s goofy, but the trademark celebration illustrates why he is loved for his sense of humour but never underestimated on track.


""", rank: 5),
            
            Driver(firstName: "Lewis", lastName: "Hamilton", team: getTeamData(for: .mercedes), imageUrl: "hamilton", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher.", rank: 1),
            
            Driver(firstName: "Valtteri", lastName: "Bottas", team: getTeamData(for: .mercedes), imageUrl: "bottas", description:
"""
Learning his craft on Finnish roads of ice and snow, he was born to be a Grand Prix racer.

Bottas explains that if you can drive on the frozen roads of his homeland then you can drive anywhere. Then there’s the Finnish mentality –reserved, diligent and calm the fast lane of F1 doesn’t faze him.

Making his F1 debut with Williams in 2013, Bottas soon became part of the family. Points and podiums followed with the reliable racer even amassing the most points without a win, a record he resented but that showcased his ability. The fact the Finn was such a points machine saw him suddenly promoted to the most coveted seat in F1 - Nico Rosberg’s vacant championship-winning seat at Mercedes.
"""
                   , rank: 2),
            
            Driver(firstName: "Charles", lastName: "Leclerc", team: getTeamData(for: .ferrari), imageUrl: "leclerc", description:
                   """
Born in the Mediterranean idyll of Monaco, Leclerc arrived in F1 on a tidal wave of expectation.

Practically peerless on his way to the GP3 and Formula 2 crowns, he showcased a dazzling array of skills from scorching pole positions, commanding victories – even when his car caught fire twice at Silverstone – to an ability to muscle his way through the pack. Winning back-to-back championships also taught Leclerc how to handle pressure, another useful tool in the big pond of Formula 1 racing.

Leclerc may have quit school early, but he looks every inch the complete driver. World champions Lewis Hamilton and Sebastian Vettel have even gone on record to say Leclerc is the real deal – and it’s not often they agree on anything…
""", rank: 7),
            
            Driver(firstName: "Carlos", lastName: "Sainz", team: getTeamData(for: .ferrari), imageUrl: "sainz", description:
                   """
He’s the matador from Madrid racing royalty.

Entering F1’s Bull Ring paired alongside Max Verstappen at Toro Rosso in 2015, Sainz quickly showed his fighting spirit. A tenacious racer, Sainz puts the car on the edge as he hustles his way through the pack. No wonder he’s earned the nickname Chilli.


But the Spaniard is intelligent as well as instinctive, thinking his way through a race and into the points. This calm temperament follows him off track where he remains unfazed by the pressures of forging a Grand Prix career with a famous name.

Sainz is the son of double World Rally champion, also his namesake, and has brought some of Dad’s driving skills to the F1 circuit – junior loves a delicious dose of drift for one.
""", rank: 6),
            
            Driver(firstName: "Fernando", lastName: "Alonso", team: getTeamData(for: .alpine), imageUrl: "alonso", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 21),
            
            Driver(firstName: "Esteban", lastName: "Ocon", team: getTeamData(for: .alpine), imageUrl: "ocon", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 12),
            
            Driver(firstName: "Nikita", lastName: "Mazepin", team: getTeamData(for: .haas), imageUrl: "mazepin", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 21),
            
            Driver(firstName: "Mick", lastName: "Schumacher", team: getTeamData(for: .haas), imageUrl: "schumacher", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 21),
            
            Driver(firstName: "Kimi", lastName: "Raikkonen", team: getTeamData(for: .alpharomeo), imageUrl: "raikkonen", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 16),
            
            Driver(firstName: "Antonio", lastName: "Giovinazzi", team: getTeamData(for: .alpharomeo), imageUrl: "giovinazzi", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 17),
            
            Driver(firstName: "Max", lastName: "Verstappen", team: getTeamData(for: .redbull), imageUrl: "verstappen", description:
"""
He’s Max by name, and max by nature.

Arriving as Formula 1’s youngest ever competitor at just 17 years old, Verstappen pushed his car, his rivals and the sport’s record books to the limit. The baby-faced Dutchman with the heart of a lion took the Toro Rosso – and then the Red Bull – by the horns with his instinctive racing style.

F1’s youngest points scorer soon became its youngest race winner – at the age of 18 years and 228 days – with an opportunistic but controlled drive on debut for Red Bull in Barcelona 2016. A true wheel-to-wheel racer, another stunning drive in Brazil from the back of the pack to the podium on a treacherous wet track kept the plaudits coming.
"""
                   , rank: 3),
            
            Driver(firstName: "Sergio", lastName: "Perez", team: getTeamData(for: .redbull), imageUrl: "perez", description:
"""
 He’s the fighter with a gentle touch from the land of the Lucha Libre.

 Perez’s reputation in F1 has been built on opposite approaches to Grand Prix racing. On the one hand, he is a punchy combatant who wrestles his way through the pack and into the points. Never afraid to add a bit of spice to his on-track encounters, even his team mates don’t always escape the Mexican’s heat.

 Then on the other hand, Perez is a smooth operator, a master at managing tyres to eke out extra performance and give him the upper hand on strategy. A firm favourite on the grid after his time with Sauber, McLaren, Force India and Racing Point, Perez has matured into an analytical racer and team leader.
 """, rank: 4),
            
            Driver(firstName: "Sebastian", lastName: "Vettel", team: getTeamData(for: .astonmartin), imageUrl: "vettel", description:
"""
    Born and raised a Bull, then a Prancing Horse, and now the face of Aston Martin’s Formula 1 revival, F1's poster boy of early achievement had won more than all but two drivers in history by the time he was just 26, including back-to-back world titles between 2010 and 2013.

    Vettel’s trademark is pure pace – and of course his one-finger victory salute. In the chase to the chequered flag, he likes to lead from the front and just like his hero, Michael Schumacher. But for all his competitive streak, Vettel has a playful side too and has been known to let loose with a spot of Beatles karaoke - and baby can he drive a car.


    Alongside his four world crowns he can boast more than 50 pole positions and race victories, ranking him – statistically - above many of the biggest names in F1 history. No wonder then that he has twice been hand-picked to return some of Grand Prix oldest names to glory.
""", rank: 13),
            
            Driver(firstName: "Lance", lastName: "Stroll", team: getTeamData(for: .astonmartin), imageUrl: "stroll", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 11),
            
            Driver(firstName: "Pierre", lastName: "Gasly", team: getTeamData(for: .alphatauri), imageUrl: "gasly", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 10),
            
            Driver(firstName: "Yuki", lastName: "Tsunoda", team: getTeamData(for: .alphatauri), imageUrl: "tsunoda", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 21),
            
            Driver(firstName: "George", lastName: "Russell", team: getTeamData(for: .williams), imageUrl: "russell", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 18),
            
            Driver(firstName: "Nicholas", lastName: "Latifi", team: getTeamData(for: .williams), imageUrl: "latifi", description: "‘Still I Rise’ – these are the words emblazoned across the back of Lewis Hamilton’s helmet and tattooed across his shoulders, and ever since annihilating expectations with one of the greatest rookie performances in F1 history in 2007, that’s literally all he’s done: risen to the top of the all-time pole positions list ahead of his hero Ayrton Senna, surged into first place in the wins column surpassing the inimitable Michael Schumacher, and then matched the legendary German’s seven world titles.", rank: 21)
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

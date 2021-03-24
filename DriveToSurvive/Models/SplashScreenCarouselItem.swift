//
//  SplashScreenCarouselItem.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/13/21.
//

import Foundation

class SplashScreenCarouselItem {
    let title: String
    let subtitle: String
    let image: String
    
    init(title: String, subtitle: String, image: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    static func loadSplashScreenItems() -> [SplashScreenCarouselItem] {

        return []
    }
}


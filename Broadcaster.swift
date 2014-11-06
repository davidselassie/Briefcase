//
//  Broadcaster.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation

class Broadcaster {
    let group: String
    
    init(group: String) {
        self.group = group
    }

    func locationPing(locator: Locator) {
        NSLog("\(self.group): Briefcase at ")//\(locator.currentLocation())")
    }
    
    func handoffPing(scoreKeeper: ScoreKeeper) {
        NSLog("\(self.group): \(scoreKeeper.currentPosession()) has the Briefcase")
    }
    
    func gameOver() {
        NSLog("\(self.group): Game Over")
    }
}

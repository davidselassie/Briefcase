//
//  ScoreKeeper.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation

class ScoreKeeper {
    internal struct Transfer {
        let to: Team
        let at: NSDate
    }

    internal let secondsPerPoint = 5.0
    
    internal var transfers: [Transfer] = []
    
    func handoffTo(team: Team, at: NSDate) {
        self.transfers.append(Transfer(to: team, at: at))
    }
    
    func scoresAt(date: NSDate) -> [Team: Int] {
        var scores: [Team: Double] = [:]
        
        if let currentTeam = self.currentPosession() {
            let hypotheticalTransfers = self.transfers + [Transfer(to: currentTeam, at: date)]
            
            let zip = Zip2(
                hypotheticalTransfers[0..<hypotheticalTransfers.count - 1],
                hypotheticalTransfers[1..<hypotheticalTransfers.count])
            for (lastTransfer, transfer) in zip {
                var pointsAccrued: Double = self.pointsFor(lastTransfer.at, to: transfer.at)
                if let previousScore = scores[lastTransfer.to] {
                    pointsAccrued += previousScore
                }
                scores[lastTransfer.to] = pointsAccrued
            }
        }

        var floorScores: [Team: Int] = [:]
        for (team, score) in scores {
            floorScores[team] = Int(floor(score))
        }
        return floorScores
    }
    
    internal func pointsFor(from: NSDate, to: NSDate) -> Double {
        return to.timeIntervalSinceDate(from) / secondsPerPoint
    }
    
    func currentPosession() -> Team? {
        return self.transfers.last?.to
    }
}

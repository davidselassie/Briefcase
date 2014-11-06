//
//  ScoreKeeperTests.swift
//  BriefcaseTests
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation
import XCTest

class ScoreKeeperTests: XCTestCase {
    let start = NSDate(timeIntervalSinceReferenceDate: 0.0)
    let minuteOne = NSDate(timeIntervalSinceReferenceDate: 60.0)
    let minuteTwo = NSDate(timeIntervalSinceReferenceDate: 120.0)
    let minuteThree = NSDate(timeIntervalSinceReferenceDate: 180.0)

    func testEmptyPosession() {
        let sk = ScoreKeeper()
        var found: Bool
        if let cp = sk.currentPosession() {
            XCTFail("Posession before handoff isn't missing")
        }
    }

    func testEmptyScore() {
        let sk = ScoreKeeper()
        XCTAssertEqual(sk.scoresAt(NSDate()), [:],
            "Scores before handoff aren't empty")
    }

    func testSingleHandoffPosession() {
        let sk = ScoreKeeper()
        sk.handoffTo(Team.Blue, at: minuteOne)
        XCTAssertEqual(sk.currentPosession()!, Team.Blue,
            "Posession after handoff isn't last team")
    }

    func testDoubleHandoffPosession() {
        let sk = ScoreKeeper()
        sk.handoffTo(Team.Blue, at: minuteOne)
        sk.handoffTo(Team.Red, at: minuteTwo)
        XCTAssertEqual(sk.currentPosession()!, Team.Red,
            "Posession after second handoff isn't last team")
    }

    func testSingleHandoffScore() {
        let sk = ScoreKeeper()
        sk.handoffTo(Team.Blue, at: minuteOne)
        let found = sk.scoresAt(minuteTwo)
        let expected = [Team.Blue: 1.0]
        XCTAssertEqual(found, expected,
            "Scores after single handoff aren't correct")
    }

    func testDoubleHandoffScore() {
        let sk = ScoreKeeper()
        sk.handoffTo(Team.Blue, at: minuteOne)
        sk.handoffTo(Team.Red, at: minuteTwo)
        let found = sk.scoresAt(minuteThree)
        let expected = [Team.Blue: 1.0, Team.Red: 1.0]
        XCTAssertEqual(found, expected,
            "Scores after second handoff aren't correct")
    }
}

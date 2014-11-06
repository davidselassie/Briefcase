//
//  RunGameViewController.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import UIKit

class RunGameViewController: UIViewController {
    @IBOutlet var redButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var gameProgress: UIProgressView!

    let gameLengthMin: Double = 1.0

    var scoreKeeper: ScoreKeeper
    var broadcaster: Broadcaster
    var locator: Locator
    var locBroadcastTimer: Timer
    var gameProgressTimer: Timer
    var gameStartTime: NSDate
    var gameOverTime: NSDate

    required init(coder aDecoder: NSCoder) {
        self.scoreKeeper = ScoreKeeper()
        self.broadcaster = Broadcaster(group: "hi")
        self.locator = Locator()

        self.locBroadcastTimer = Timer()
        self.gameProgressTimer = Timer()
        self.gameStartTime = NSDate()
        self.gameOverTime = NSDate(timeIntervalSinceNow: gameLengthMin * 60.0)

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        self.locBroadcastTimer = Timer(
            interval: 5.0,
            callback: self.locBroadcastTick)
        self.locBroadcastTimer.start()
        self.gameProgressTimer = Timer(
            interval: 0.1,
            callback: self.gameProgressTick)
        self.gameProgressTimer.start()
        super.viewDidLoad()
    }

    @IBAction func redClick() {
        self.scoreKeeper.handoffTo(Team.Red, at: NSDate())
        self.broadcaster.handoffPing(self.scoreKeeper)
        self.setProgressTint(0.0)
    }

    @IBAction func blueClick() {
        self.scoreKeeper.handoffTo(Team.Blue, at: NSDate())
        self.broadcaster.handoffPing(self.scoreKeeper)
        self.setProgressTint(235.0 / 360.0)
    }

    func setProgressTint(hue: CGFloat) {
        self.gameProgress.trackTintColor = UIColor(hue: hue, saturation: 0.2, brightness: 1.0, alpha: 1.0)
        self.gameProgress.progressTintColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }

    func locBroadcastTick() {
        self.broadcaster.locationPing(self.locator)
    }

    func gameProgressTick() {
        let now = NSDate()
        var ratio: Double = now.timeIntervalSinceDate(self.gameStartTime) / self.gameOverTime.timeIntervalSinceDate(self.gameStartTime)
        ratio = ratio > 1.0 ? 1.0 : ratio

        self.gameProgress.progress = Float(ratio)

        if ratio >= 1.0 {
            self.broadcaster.gameOver()
        }

        let scores = self.scoreKeeper.scoresAt(now)
        self.redButton.titleLabel?.text = "Red \(floor(scores[Team.Red] ?? 0.0))"
        self.blueButton.titleLabel?.text = "Blue \(floor(scores[Team.Blue] ?? 0.0))"
    }
}

//
//  Broadcaster.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation
import Social
import Accounts

class Broadcaster {
    let twitterAccount: ACAccount
    
    init(twitterAccount: ACAccount) {
        self.twitterAccount = twitterAccount
    }

    func locationPing(locator: Locator) {
        locator.currentLocation({
            (placeName: String) in
            self.tweet("Briefcase at \(placeName)")
        })
    }
    
    func handoffPing(scoreKeeper: ScoreKeeper) {
        self.tweet("\(scoreKeeper.currentPosession()?) has the Briefcase")
    }

    func scorePing(scores: [Team: Int]) {
        self.tweet("Point scored: \(scores)")
    }
    
    func gameOver(finalScores: [Team: Int]) {
        self.tweet("Game Over: \(finalScores)")
    }

    internal func tweet(text: String) {
        var request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: SLRequestMethod.POST,
            URL: NSURL(string: "https://api.twitter.com/1/statuses/update.json"),
            parameters: ["status": text])
        request.account = self.twitterAccount

        NSLog("\(self.twitterAccount.username) <- \"\(text)\"")

        request.performRequestWithHandler({
            (response: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in

            if urlResponse.statusCode != 200 {
                NSLog("\(self.twitterAccount.username) -> \(urlResponse.statusCode): \"\(NSString(data: response, encoding: NSUTF8StringEncoding))\"")
            }
        })
    }
}

//
//  Timer.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation

class Timer {
    internal var timer = NSTimer()
    
    internal let interval: NSTimeInterval
    internal let callback: () -> ()

    init() {
        self.interval = -1.0
        self.callback = { () -> () in return }
    }
    
    init(interval: NSTimeInterval, callback: () -> ()) {
        self.interval = interval
        self.callback = callback
    }
    
    func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("onTick"), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    @objc internal func onTick() {
        self.callback()
    }
    
    deinit {
        self.timer.invalidate()
    }
}

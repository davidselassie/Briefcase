//
//  Team.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation

enum Team {
    case Red, Blue

    func description() -> String {
        switch self {
        case Red:
            return "Red"
        case Blue:
            return "Blue"
        }
    }
}

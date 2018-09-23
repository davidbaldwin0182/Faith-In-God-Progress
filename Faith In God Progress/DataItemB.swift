//
//  DataItemB.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import Foundation
import UIKit

class DataItemB {
    let item: String
    let name: String
    let name2: String
    let message: String
    let message2: String
    let checkMarked: String
    let checkValue: String
    let index: Int
    let study: String
    let study2: String
    
    init(item: String, name: String, name2: String, message: String, message2: String, checkMarked: String, checkValue:String, index: Int, study: String, study2: String) {
        self.item = item
        self.name = name
        self.name2 = name2
        self.message = message
        self.message2 = message2
        self.checkMarked = checkMarked
        self.checkValue = checkValue
        self.index = index
        self.study = study
        self.study2 = study2
    }
    
    var ckecked: UIImage? {
        return UIImage(named: checkMarked)
    }
}

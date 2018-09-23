//
//  DataItemA.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import Foundation
import UIKit

class DataItemA {
    let item: String
    let name: String
    let message: String
    let checkMarked: String
    let checkValue: String
    let index: Int
    let study: String
    
    
    init(item: String, name: String, message: String, checkMarked: String, checkValue:String, index: Int, study: String) {
        self.item = item
        self.name = name
        self.message = message
        self.checkMarked = checkMarked
        self.checkValue = checkValue
        self.index = index
        self.study = study
    }
    
    var ckecked: UIImage? {
        return UIImage(named: checkMarked)
    }
}

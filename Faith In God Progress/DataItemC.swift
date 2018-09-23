//
//  DataItemC.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/8/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import Foundation
import UIKit

class DataItemC {
    let name: String
    let imageQuote: String
    let imageBlank: String
    let checkMarked: String
    let checkValue: String
    let index: Int
    
    init(name: String, imageQuote: String, imageBlank: String, checkMarked: String, checkValue:String, index: Int) {
        self.name = name
        self.imageQuote = imageQuote
        self.imageBlank = imageBlank
        self.checkMarked = checkMarked
        self.checkValue = checkValue
        self.index = index
    }
    
    var quote: UIImage? {
        return UIImage(named: imageQuote)
    }
    var blank: UIImage? {
        return UIImage(named: imageBlank)
    }
    var ckecked: UIImage? {
        return UIImage(named: checkMarked)
    }
    
}

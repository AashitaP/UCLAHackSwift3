//
//  Pokemon.swift
//  session3
//
//  Created by Aashita on 9/5/17.
//  Copyright © 2017 aashita. All rights reserved.
//

import UIKit //MVC model, so need a model to display

class Pokemon: NSObject {

    var name: String
    var imageURL: URL
    
    init(name:String, imageURL: String) {
        self.name = name
        self.imageURL = URL(string: imageURL)!
        
        
    }
}

//
//  Continent.swift
//  AnimalsContinents
//
//  Created by Bruno on 14/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class Continent {
    var name : String
    var clime : String
    var ext : Int64
    var photo : String?
    
    init?(name: String, clime: String, ext: Int64, photo: String?) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.clime = clime
        self.ext = ext
        self.photo = photo
    }
}

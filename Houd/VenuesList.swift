//
//  VenuesList.swift
//  HTTP
//
//  Created by Isabelle lecrer on 24/04/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import Foundation

struct VenuesList {
    let name : String
    let street : String
    let postalCode: String
    let city: String
    let state: String
    let country: String
    
    init(name: String, street: String, postalCode: String, city: String, state: String, country: String){
        self.name = name
        self.street = street
        self.postalCode = postalCode
        self.city = city
        self.state = state
        self.country = country
    }
    
} 

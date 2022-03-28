//
//  Model.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation

struct CoctailsResponse: Decodable {
    var items: [Coctail]
    
    enum CodingKeys: String, CodingKey {
        case items = "drinks"
    }
}

struct Coctail: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
    }
}

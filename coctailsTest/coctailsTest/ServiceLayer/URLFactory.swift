//
//  URLFactory.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//
// https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic

import Foundation

struct URLFactory {
    
    private static let baseUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thecocktaildb.com"
        components.path = "/api/json/v1/1/filter.php"
        return components
    }()
    
    static func coctails(params: CoctailsRequestParams) -> URL? {
        let methodQueryItems = params.parameters.map { URLQueryItem(name: $0, value: $1) }
        var resultComponents = baseUrlComponents
        resultComponents.queryItems = methodQueryItems
        
        return resultComponents.url
    }
}


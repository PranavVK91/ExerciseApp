//
//  CountryModel.swift
//  ExerciseApp
//
//  Created by Pranav V K on 09/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    let title: String
    var details: [CountryDetailsModel]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case details = "rows"
    }
}

struct CountryDetailsModel: Codable {
    let title: String?
    let description: String?
    let imageUrl: String?
    
    func getImageUrl() -> URL? {
        makeUrlFromString(stringUrl: imageUrl ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageUrl = "imageHref"
    }
}

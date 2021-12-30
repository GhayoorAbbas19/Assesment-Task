//
//  VideosModel.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 30/12/2021.
//

import Foundation

// MARK: - VideosModel
struct VideosModel: Codable {
    let id: Int?
    let results: [VideoResult]?
}

// MARK: - Result
struct VideoResult: Codable {
    let iso639_1: ISO639_1?
    let iso3166_1: ISO3166_1?
    let name, key: String?
    let site: Site?
    let size: Int?
    let type: TypeEnum?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1
        case iso3166_1
        case name, key, site, size, type, official
        case publishedAt
        case id
    }
}

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Codable {
    
    case clip = "Clip"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
}

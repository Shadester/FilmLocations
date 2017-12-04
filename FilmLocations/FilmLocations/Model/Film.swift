//
//  Film.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

struct Film : Codable {
    let actor_1 : String?
    let actor_2 : String?
    let actor_3 : String?
    let director : String?
    let locations : String?
    let production_company : String?
    let release_year : String?
    let title : String?
    let writer : String?

    enum CodingKeys: String, CodingKey {

        case actor_1 = "actor_1"
        case actor_2 = "actor_2"
        case actor_3 = "actor_3"
        case director = "director"
        case locations = "locations"
        case production_company = "production_company"
        case release_year = "release_year"
        case title = "title"
        case writer = "writer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actor_1 = try values.decodeIfPresent(String.self, forKey: .actor_1)
        actor_2 = try values.decodeIfPresent(String.self, forKey: .actor_2)
        actor_3 = try values.decodeIfPresent(String.self, forKey: .actor_3)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        locations = try values.decodeIfPresent(String.self, forKey: .locations)
        production_company = try values.decodeIfPresent(String.self, forKey: .production_company)
        release_year = try values.decodeIfPresent(String.self, forKey: .release_year)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
    }

}

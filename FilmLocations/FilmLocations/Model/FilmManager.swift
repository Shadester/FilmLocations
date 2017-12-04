//
//  NetworkManager.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

import Foundation

class FilmManager {

    static let sharedInstance = FilmManager()

    public var films: [Film]?

    typealias FilmCompletionHandler = ([Film?]) -> ()

    public func getFilms(completion: @escaping FilmCompletionHandler) {
        let url = URL(string: "https://data.sfgov.org/resource/wwmu-gmzc.json?$limit=100000")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                self.films = try decoder.decode([Film].self, from: data!)
                completion(self.films!)
            } catch let error {
                print("got an error: \(error)")
                completion([])
            }
        }
        task.resume()
    }
}


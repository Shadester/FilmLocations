//
//  ViewController.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

import UIKit

class FilmTableController: UITableViewController {

    private var moviesArray = [Film?]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Film locations in San Francisco"
        
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "Cell")
        FilmManager.getFilms {(films) in
            DispatchQueue.main.async {
                self.moviesArray = films
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilmTableViewCell
        cell.displayFilmInCell(film: moviesArray[indexPath.row]!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmLocationMapViewController = FilmLocationMapViewController()
        filmLocationMapViewController.filmLocation = moviesArray[indexPath.row]?.locations
        filmLocationMapViewController.filmTitle = moviesArray[indexPath.row]?.title
        navigationController?.pushViewController(filmLocationMapViewController, animated: false)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}




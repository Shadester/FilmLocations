//
//  ViewController.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

import UIKit

class FilmTableController: UITableViewController {

    var movies = [Film?]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    var filteredMovies = [Film?]()
    let searchController = UISearchController(searchResultsController: nil)

    enum SearchOn: Int {
        case Title = 0
        case Year
        case Director
        case Location
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // No smart searchcontroller on earlier versions :(
        }

        definesPresentationContext = true

        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Title", "Year", "Director", "Location"]
        searchController.searchBar.delegate = self
        
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "Cell")
        FilmManager.getFilms { (films) in
            DispatchQueue.main.async {
                self.movies = films
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Film locations in San Francisco"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilmTableViewCell
        var film: Film
        if isFiltering() {
            film = filteredMovies[indexPath.row]!
        } else {
            film = movies[indexPath.row]!
        }
        cell.displayFilmInCell(film: film)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var film: Film
        if isFiltering() {
            film = filteredMovies[indexPath.row]!
        } else {
            film = movies[indexPath.row]!
        }
        let filmLocationMapViewController = FilmLocationMapViewController()
        filmLocationMapViewController.filmLocation = film.locations
        filmLocationMapViewController.filmTitle = film.title
        self.title = "Back"
        navigationController?.pushViewController(filmLocationMapViewController, animated: false)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    private func filterContentForSearchText(_ searchText: String, scope: SearchOn) {
        filteredMovies = movies.filter({( film : Film?) -> Bool in
            if searchBarIsEmpty() {
                return true
            }

            if let film = film {
                if let title = film.title, scope == SearchOn.Title{
                    return title.lowercased().contains(searchText.lowercased())
                } else if let year = film.release_year, scope == SearchOn.Year {
                    return year.lowercased().contains(searchText.lowercased())
                } else if let director = film.director, scope == SearchOn.Director {
                    return director.lowercased().contains(searchText.lowercased())
                } else if let location = film.locations, scope == SearchOn.Location {
                    return location.lowercased().contains(searchText.lowercased())
                }
            }

            return false
        })

        tableView.reloadData()
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && (!searchBarIsEmpty())
    }
}

extension FilmTableController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let scope = SearchOn(rawValue: selectedScope) {
            filterContentForSearchText(searchBar.text!, scope: scope)
        }
    }
}

extension FilmTableController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let scope = SearchOn(rawValue: searchBar.selectedScopeButtonIndex) {
            filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        }
    }
}





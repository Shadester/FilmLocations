//
//  FilmTableViewCell.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        addSubview(movieTitleLabel)
        movieTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true

        addSubview(yearLabel)
        yearLabel.leftAnchor.constraint(equalTo: movieTitleLabel.rightAnchor, constant: 10).isActive = true
        yearLabel.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor).isActive = true

        addSubview(directorLabel)
        directorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        directorLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true

        addSubview(locationLabel)
        locationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        locationLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    func displayFilmInCell(film: Film) {
        movieTitleLabel.text = film.title
        yearLabel.text = "(\(film.release_year ?? ""))"
        directorLabel.text = film.director
        locationLabel.text = film.locations
    }


    let movieTitleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()

    let yearLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()

    let directorLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()

    let locationLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()

}

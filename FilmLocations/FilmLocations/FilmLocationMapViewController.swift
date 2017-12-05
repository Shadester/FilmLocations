//
//  FilmLocationMapViewController.swift
//  FilmLocations
//
//  Created by Erik Lindberg on 2017-12-04.
//  Copyright © 2017 fakeapps. All rights reserved.
//

import UIKit
import MapKit

class FilmLocationMapViewController: UIViewController {

    var filmLocation: String?
    var filmTitle: String?
    let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(37.7749, -122.4194), 10000, 10000) // San Francisco coordinates and within a 20km bounding box.

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)

        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            mapView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0).isActive = true
            guide.bottomAnchor.constraintEqualToSystemSpacingBelow(mapView.bottomAnchor, multiplier: 1.0).isActive = true
        } else {
            let standardSpacing: CGFloat = 8.0
            mapView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing).isActive = true
            bottomLayoutGuide.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: standardSpacing).isActive = true
        }

        self.title = filmTitle

        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = filmLocation // This is to have a bit better search, since the addresses in the database is weirdly formatted.
        localSearchRequest.region = region
        let localSearch = MKLocalSearch(request: localSearchRequest)

        localSearch.start { [weak self]  (localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                self?.showNotFound()
                return
            }
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = self?.filmLocation
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)

            // Show annotation if search result is inside San Francisco
            if(MKMapRectContainsPoint((self?.MKMapRectForCoordinateRegion(region: (self?.region)!))!, MKMapPointForCoordinate(pointAnnotation.coordinate))) {
                let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
                self?.mapView.centerCoordinate = pointAnnotation.coordinate
                self?.mapView.region = MKCoordinateRegionMakeWithDistance(pointAnnotation.coordinate, 500, 500)
                self?.mapView.addAnnotation(pinAnnotationView.annotation!)
            } else {
                self?.showNotFound()
                return
            }

        }

    }

    func showNotFound() {
        let alertController = UIAlertController(title: "Place not found", message: "Look at another location", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: false)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Shamelessly borrowed from https://stackoverflow.com/questions/9270268/convert-mkcoordinateregion-to-mkmaprect to figure out if returned location actually is in San Francisco
    func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))

        let a = MKMapPointForCoordinate(topLeft)
        let b = MKMapPointForCoordinate(bottomRight)

        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }

    let mapView: MKMapView = {
        let m = MKMapView()
        m.translatesAutoresizingMaskIntoConstraints = false
        m.mapType = MKMapType.standard
        m.isZoomEnabled = true
        m.isScrollEnabled = true
        return m
    }()
}

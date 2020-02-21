//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Maitree Bain on 2/21/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    private let locationSession = CoreLocationSession()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing converting coordinate to placemark
        convertCoordinateToPlacemark()
        //testing converting placename to coords
        convertPlacenametoCoordinate()
        
        //configure map view
        //attempt to show the user's current location
        mapView.showsUserLocation = true
        
        mapView.delegate = self
        loadMapView()
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for location in Location.getLocations() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotations.append(annotation)
        }
        return annotations
    }
    
    private func loadMapView() {
        let annotaions = makeAnnotations()
        mapView.addAnnotations(annotaions)
        mapView.showAnnotations(annotaions, animated: true)
    }
    
    private func convertCoordinateToPlacemark() {
        if let location = Location.getLocations().first {
            locationSession.convertCoordinateToPlacemark(coordinate: location.coordinate)
        }
    }
    
    private func convertPlacenametoCoordinate() {
        locationSession.convertPlacemarkToCoordinate(addressString: "Milan")
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "locationAnnotation"
        let annotationView: MKPinAnnotationView
        
        //try to deque and reuse annotation view
        if let dequeView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = dequeView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        
        return annotationView
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    
}

//
//  ViewController.swift
//  MapKitBasic
//
//  Created by James MacIsaac on 2018-02-05.
//  Copyright © 2018 James MacIsaac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UIGestureRecognizerDelegate{

    // Outlet for Map View
    @IBOutlet weak var mapView: MKMapView!
    var points: [MKPointAnnotation] = []
    var myRoute : MKRoute!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location at the U of C
        let initialLocation = CLLocation(latitude: 51.079948, longitude: -114.135000)
        
        let regionRadius: CLLocationDistance = 1800
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(recognizer:)))
        tap.delegate = self
        self.mapView.addGestureRecognizer(tap)
        print("Set the tap gesture recognizer!")
    }

    @IBAction func handleTap(recognizer:UITapGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.mapView)
        let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
        
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
        mapView.addAnnotation(point)
        points.append(point)
        
        let directionsRequest = MKDirectionsRequest()
        
        let start = MKPlacemark(coordinate: CLLocationCoordinate2DMake(points[0].coordinate.latitude, points[0].coordinate.longitude), addressDictionary: nil)
        let end = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: start)
        directionsRequest.destination = MKMapItem(placemark: end)
        
        directionsRequest.transportType = MKDirectionsTransportType.walking
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate(completionHandler: {
            response, error in
            
            if error == nil {
                self.myRoute = response!.routes[0] as MKRoute
                self.mapView.add(self.myRoute.polyline)
            }
            
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.red
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


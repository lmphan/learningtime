//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Lauren Phan on 1/22/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])

        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let userLocationButton = UIButton(type: UIButton.ButtonType.custom)
        userLocationButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        userLocationButton.backgroundColor = UIColor.systemBlue
        userLocationButton.setTitle("Zoom to user location", for: .normal)
        userLocationButton.addTarget(self, action: #selector(MapViewController.zoomToUserLocation), for: UIControl.Event.touchUpInside)
        view.addSubview(userLocationButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func zoomToUserLocation() {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = mapView.userLocation.coordinate
        mapRegion.span.latitudeDelta = 0.2
        mapRegion.span.longitudeDelta = 0.2
        
        mapView.setRegion(mapRegion, animated: true)
    }
}

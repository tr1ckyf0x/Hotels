//
//  MapViewController.swift
//  Hotels
//
//  Created by Владислав Лисянский on 06/02/2019.
//  Copyright © 2019 Владислав Лисянский. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var viewModel: MapViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    viewModel.annotation.subscribe(onNext: { [weak mapView] mapPin in
      if let annotations = mapView?.annotations {
        mapView?.removeAnnotations(annotations)
      }
      mapView?.addAnnotation(mapPin)
      
      let regionRadius: CLLocationDistance = 1000
      let coordinateRegion = MKCoordinateRegion(center: mapPin.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView?.setRegion(coordinateRegion, animated: true)
      
    }).disposed(by: rx.disposeBag)
  }
  
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? MapPin else { return nil }
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: 0, y: 0)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
}

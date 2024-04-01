//
//  MapViewController.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 02/04/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //MARK: - PROPERTIES.
    @IBOutlet private weak var mapView: MKMapView!
    var truckInfo: [TruckDataModel] = []
    
    //MARK: - VIEW's LIFECYCLE METHODS.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - FUNCTION TO CONFIGURE UI.
    private func configureUI() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        markAnnotation()
    }
    
    //MARK: - FUNCTION TO HANDLE BACK BUTTON ACTION.
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func markAnnotation() {
        for truck in truckInfo {
            let annotation = MKPointAnnotation()
            annotation.title = truck.truckNumber
            annotation.coordinate = CLLocationCoordinate2D(latitude: truck.lastWaypoint?.lat ?? 0, longitude: truck.lastWaypoint?.lng ?? 0)
            
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
                return nil
            }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            } else {
                annotationView?.annotation = annotation
            }
            
        annotationView?.image = UIImage(systemName: "truck.box.fill")
        return annotationView
    }
}

//
//  LocationViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ica, Perú"
        let centre = CLLocationCoordinate2D(latitude:  -9.189967, longitude: -75.015152)
        locationView.setCenter(centre, animated: false)
        let pin = MKPointAnnotation()
        pin.coordinate = centre
        locationView.addAnnotation(pin)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.title = "Anything Else"
    }
    


}

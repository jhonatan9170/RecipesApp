//
//  LocationViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit
import MapKit

protocol LocationViewControllerProtocol {
    func updateMap()
}

class LocationViewController: UIViewController {
    
    @IBOutlet weak private var locationView:MKMapView! {
        didSet{
            let centre = CLLocationCoordinate2D(latitude:  -9.189967, longitude: -75.015152)
            locationView.setCenter(centre, animated: false)
            locationView.isHidden = true
        }
    }
    
    var viewModel: LocationViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel?.getCoordinates()
    }
    
    private func setupViews() {
        view.addSpinner()
        if let location = viewModel?.location {
            self.title = location + ", Perú"
        }
    }
    
    private func showError() {
        view.removeSpinner()
        locationView.isHidden = false
    }
}

extension LocationViewController: LocationViewControllerProtocol {
    
    func updateMap() {
        locationView.isHidden = false
        let pin = MKPointAnnotation()
        if let coordinates = viewModel?.coordidates {
            pin.coordinate = coordinates
        } else {
            showError()
        }
        view.removeSpinner()
        locationView.addAnnotation(pin)
    }
}


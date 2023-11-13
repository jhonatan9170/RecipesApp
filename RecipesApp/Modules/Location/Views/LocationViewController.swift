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
    
    var viewModel: LocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        viewModel.delegate = self
        viewModel.getCoordinates()
    }
    
    func setupViews() {
        view.addSpinner()
        self.title = viewModel.location + ", Perú"
        let centre = CLLocationCoordinate2D(latitude:  -9.189967, longitude: -75.015152)
        locationView.setCenter(centre, animated: false)
        locationView.isHidden = true
    }
}

extension LocationViewController: LocationViewModelDelegate{
    func success(_ viewModel: LocationViewModel) {
        guard let coordinates = viewModel.coordinates else {
            error(viewModel)
            return
        }
        locationView.isHidden = false
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
            self?.locationView.addAnnotation(pin)
        }
    }
    
    func error(_ viewModel: LocationViewModel) {

        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
            self?.locationView.isHidden = false
        }
    }

}

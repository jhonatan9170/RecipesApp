//
//  LocationViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit
import MapKit

protocol LocationViewControllerProtocol:AnyObject {
    func updateMap(with coordinates: CLLocationCoordinate2D)
    func updateSpinner(loading: Bool)
}

class LocationViewController: UIViewController {
    
    @IBOutlet weak private var locationView:MKMapView! {
        didSet{
            let centre = CLLocationCoordinate2D(latitude:  -9.189967, longitude: -75.015152)
            locationView.setCenter(centre, animated: false)
            locationView.isHidden = true
        }
    }
    
    var viewModel: LocationViewModelProtocol
    
    init(viewModel: LocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LocationViewController.self), bundle: Bundle.main)
        viewModel.setViewControllerProtocol(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.location
        viewModel.getCoordinates()
    }
}

extension LocationViewController: LocationViewControllerProtocol {
    
    func updateMap(with coordinates: CLLocationCoordinate2D) {
        locationView.isHidden = false
        let pin = MKPointAnnotation(__coordinate: coordinates)
        locationView.addAnnotation(pin)
    }
    
    func updateSpinner(loading: Bool){
        loading ? view.addSpinner() : view.removeSpinner()
    }
}


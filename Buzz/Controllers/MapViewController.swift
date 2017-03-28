//
//  MapViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 3/27/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit
import MapKit
import TSClusterMapView

class MapViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search"
            searchBar.delegate = self
            searchBar.backgroundColor = .clear
            searchBar.backgroundImage = UIImage()
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
    }
    
    @IBOutlet weak var mapView: TSClusterMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    let results = Dummy.sharedInstance.makeSearchResults(5).flatMap { $0 as? Location }
    var filtered = [SearchResultProtocol]() {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.reload()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtered = results
    }
    
    func reload() {
        mapView.removeAllAnnotations()
        
        let filtered = self.filtered.flatMap { $0 as? Location }
        for item in filtered {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.coordinate
            annotation.title = item.name
            mapView.addClusteredAnnotation(annotation)
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension MapViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            self.filtered = searchText.isEmpty ? self.results : self.results.lazy.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
    
}

// MARK: - MKMapViewDelegate
extension MapViewController: TSClusterMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "MKAnnotationView")
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: "MKAnnotationView")
            pin?.canShowCallout = true
            pin?.image = UIImage(named: "ClusterAnnotation")
        } else {
            pin?.annotation = annotation
        }
        return pin
    }
    
    func mapView(_ mapView: TSClusterMapView!, viewForClusterAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "MKClusterAnnotationView")
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: "MKClusterAnnotationView")
            pin?.canShowCallout = true
            pin?.image = UIImage(named: "ClusterAnnotation")
        } else {
            pin?.annotation = annotation
        }
        return pin
    }
    
    func mapView(_ mapView: TSClusterMapView!, shouldForceSplitClusterAnnotation clusterAnnotation: ADClusterAnnotation!) -> Bool {
        return true
    }
    
    func mapView(_ mapView: TSClusterMapView!, shouldRepositionAnnotations annotations: [ADClusterAnnotation]!, toAvoidClashAt coordinate: CLLocationCoordinate2D) -> Bool {
        return true
    }
    
}

class ClusterAnnotation: TSRefreshedAnnotationView {
    
    lazy var label: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        self.addSubview(label)
        label.constrainToEdges()
        return label
    }()
    
    override var annotation: MKAnnotation? {
        didSet {
            let annotation = ADClusterAnnotation()
            label.text = "\(annotation.clusterCount)"
        }
    }
    
}

class Annotation: NSObject, MKAnnotation {
    
    var item: Location!
    
    var coordinate: CLLocationCoordinate2D {
        return item.coordinate
    }
    
    var title: String? {
        return item.name
    }
    
}

//
//  SearchViewController.swift
//  FitnessApp
//
//  Created by Trek on 11/18/22.
//

import UIKit
import MapKit
import CoreLocation
import AlamofireImage

struct Location{
    let lat: String
    let lng: String
}
struct Geometry{
    let addresses: [String: Any]
}

struct Data{
    static var places = [[String:Any]]()
}

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let mapView = MKMapView()
    let searchVC = UISearchController(searchResultsController: ResultsViewController())
    var nearbyPlaces = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        title = "Nearby Gym"
        
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        searchVC.hidesNavigationBarDuringPresentation = false
//        let annotations = mapView.annotations
//        mapView.removeAnnotations(annotations)
        // Do any additional setup after loading the view.
        
//        if let coor = mapView.userLocation.location?.coordinate{
//            didTapPlace(with: coor)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.30249727080044, longitude: -120.48294761375044)
        didTapPlace(with: coordinate)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
//        mapView.frame = view.bounds
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? ResultsViewController else {
            return
        }
        
        resultVC.delegate = self
        
        GooglePlacesManager.shared.findPlaces(query: query) {
            result in
            switch result{
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: ResultsViewControllerDelegate {
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil)
        
//        print(coordinates)
//        let annotations = mapView.annotations
//        mapView.removeAnnotations(annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(
                latitudeDelta: 0.05 , longitudeDelta: 0.05)
        ), animated: true)
        
        DispatchQueue.main.async {
            self.getData(with: coordinates)
//            self.getAnnotations()
        }
    }

    func getData(with coordinate: CLLocationCoordinate2D) {
        var allLocations = [[String:Any]]()
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=10000&types=gym&opennow&key=AIzaSyAD4dYBn4S0piz2hhzULtN88Fgw5bVVNfI")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let places = dataDictionary["results"] as! [[String : Any]]
                 allLocations = places
                 self.getAnnotations(with: allLocations)
             }
        }
        task.resume()
    }
    
    func getAnnotations(with places: [[String: Any]]) {
//        print(places.count)
        for count in 0...places.count-1 {
//            print(count)
            let currentLocation = places[count]
            if let geometry = currentLocation["geometry"] as? NSDictionary {
                let location = geometry["location"] as! [String: Any]
                let latitude = location["lat"] as! Double
                let longitude = location["lng"] as! Double
                let coordinate = CLLocationCoordinate2D(latitude: Double(latitude), longitude: Double(longitude))
//                print(coordinate)
                DispatchQueue.main.async {
                    let pin = MKPointAnnotation()
                    pin.coordinate = coordinate
                    pin.title = currentLocation["name"] as? String
                    if let rating = currentLocation["rating"] as? Double {
                        pin.subtitle = "Rating: " + (String(describing: (rating)))
                                        } else {
                            pin.subtitle = "Rating: Coming Soon"
                        }
                    self.mapView.addAnnotation(pin)
                }
                
            }
        }
    }
}

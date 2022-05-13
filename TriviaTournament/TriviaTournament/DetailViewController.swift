//
//  DetailViewController.swift
//  TriviaTournament
//
//  Created by Vy Nghiem on 12/3/21.
//

import Foundation
import UIKit
import AVKit
import WebKit
import MapKit
import CoreLocation

class DetailViewController : UIViewController, MKMapViewDelegate {

    var passedQuestion:Question = Question()
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var wkBrowser: WKWebView!
    
    @IBOutlet weak var mapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the webkit function
        loadWebKitContent()
        
        // set the label name to display product name
        lblName.text = "Find the best \n" + passedQuestion.QuestionTopic + "\n here:"
        lblName.layer.borderColor = UIColor.darkGray.cgColor
        lblName.layer.borderWidth = 1.0
        
        let lat = passedQuestion.QuestionLat
        let lon = passedQuestion.QuestionLon
        let globalCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        // adjust how closed-up the map view displays
        mapView.setRegion(MKCoordinateRegion(center: globalCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        mapView.delegate = self
        mapView.layer.borderColor = UIColor.darkGray.cgColor
        mapView.layer.borderWidth = 1.0
        addStorePin()
    }
    
    
    private func addStorePin(){
        let pin = MKPointAnnotation()
        let pinLat = passedQuestion.QuestionLat
        let pinLon = passedQuestion.QuestionLon
        let pinCoordinate = CLLocationCoordinate2D(latitude: pinLat, longitude: pinLon)
        pin.coordinate = pinCoordinate
        pin.title = "Store"
        pin.subtitle = "Is Here"
        mapView.addAnnotation(pin)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else{ return nil }
    
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        let identifier = "Annotation"
        
        if annotationView == nil {
            //create the view
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
    
        return annotationView
    }

    
    func loadWebKitContent() {
        let questionSiteURL = URL(string: passedQuestion.QuestionSite)
        let request = URLRequest(url: questionSiteURL!)
        // webkit is a browser control that can display anything
        wkBrowser.load(request)
    }

}

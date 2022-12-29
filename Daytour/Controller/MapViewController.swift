import UIKit
import MapKit

class MapViewController: UIViewController {
	private let mapView = MKMapView()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(mapView)
		mapView.frame = self.view.frame
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
	}
}

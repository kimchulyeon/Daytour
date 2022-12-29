import UIKit
import MapKit

class HomeBodyMapView: UIView {
	//MARK: - Properties
	private let locationManager = CLLocationManager()
	private let mapVC = MapViewController()

	//MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		locationManager.delegate = self
		
		translatesAutoresizingMaskIntoConstraints = false
		layer.masksToBounds = true
		layer.cornerRadius = 15
		
		addSubview(mapVC.view)
		
		enableLocationService()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}

extension HomeBodyMapView {
	//MARK: - Helper function
}

//MARK: - location manager delegate
extension HomeBodyMapView: CLLocationManagerDelegate {
	func enableLocationService() {
		switch locationManager.authorizationStatus {
		case .notDetermined:
			print("DEBUG::: : Not determined...")
			locationManager.requestWhenInUseAuthorization()
		case .restricted, .denied:
			break
		case .authorizedAlways:
			print("DEBUG::: : Auth always...")
			locationManager.startUpdatingLocation()
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
		case .authorizedWhenInUse:
			print("DEBUG::: : Auth when in use...")
			locationManager.requestAlwaysAuthorization()
		@unknown default:
			break
		}
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestAlwaysAuthorization()
		}
	} }


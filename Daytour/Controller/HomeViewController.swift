import UIKit
import Firebase

class HomeViewController: UIViewController {
	//MARK: - Properties
	private let homeContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	private let homeHeader = HomeHeaderStackView()
	private let homeBody = HomeBodyMapView()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		checkLogin()
	}
	

	//MARK: - API
	func checkLogin() {
		if Auth.auth().currentUser?.uid == nil {
			DispatchQueue.main.async {
				let nav = UINavigationController(rootViewController: LoginViewController())
				nav.modalPresentationStyle = .fullScreen
				self.present(nav, animated: false)
			}
		} else {
			configureUI()
		}
	}

	//MARK: - helper function
	func configureUI() {
		view.addSubview(homeContainer)
		homeContainer.addSubview(homeHeader)
		homeContainer.addSubview(homeBody)
		
		// Container
		NSLayoutConstraint.activate([
			homeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: homeContainer.trailingAnchor, multiplier: 0),
			homeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		// Home header
		NSLayoutConstraint.activate([
			homeHeader.topAnchor.constraint(equalTo: homeContainer.topAnchor),
			homeHeader.leadingAnchor.constraint(equalTo: homeContainer.leadingAnchor),
			homeHeader.trailingAnchor.constraint(equalTo: homeContainer.trailingAnchor)
		])
		// Home body
		NSLayoutConstraint.activate([
			homeBody.topAnchor.constraint(equalTo: homeHeader.bottomAnchor, constant: 25),
			homeBody.leadingAnchor.constraint(equalTo: homeContainer.leadingAnchor, constant: 10),
			homeBody.trailingAnchor.constraint(equalTo: homeContainer.trailingAnchor, constant: -10),
			homeBody.bottomAnchor.constraint(equalTo: homeContainer.bottomAnchor, constant: -150)
		])
	}
//	func signOut() {
//		do {
//			try Auth.auth().signOut()
//			let nav = UINavigationController(rootViewController: LoginViewController())
//			nav.modalPresentationStyle = .fullScreen
//			self.present(nav, animated: false)
//		} catch {
//			print("Error Sign Out")
//		}
//	}
	
	//MARK: - Selector
//	@objc func handleLogout() {
//		self.signOut()
//	}
}

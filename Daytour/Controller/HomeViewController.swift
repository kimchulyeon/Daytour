import UIKit
import Firebase

class HomeViewController: UIViewController {
	//MARK: - Properties
	private let homeContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let homeHeader = HomeHeaderStackView()

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
	}
	func signOut() {
		do {
			try Auth.auth().signOut()
			let nav = UINavigationController(rootViewController: LoginViewController())
			nav.modalPresentationStyle = .fullScreen
			self.present(nav, animated: false)
		} catch {
			print("Error Sign Out")
		}
	}
	
	//MARK: - Selector
//	@objc func handleLogout() {
//		self.signOut()
//	}
}

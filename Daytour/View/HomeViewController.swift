import UIKit
import Firebase

class HomeViewController: UIViewController {
	//MARK: - Properties
	private let homeContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .blue
		return view
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		checkLogin()
		signOut()
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
		self.view.addSubview(homeContainer)
		NSLayoutConstraint.activate([
			homeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: homeContainer.trailingAnchor, multiplier: 0),
			homeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),

		])
	}
	func signOut() {
		do {
			try Auth.auth().signOut()
		} catch {
			print("Error Sign Out")
		}
	}
}

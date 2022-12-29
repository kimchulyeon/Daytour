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
	lazy var logoutButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("logout", for: .normal)
		btn.setTitleColor(UIColor.white, for: .normal)
		btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
		return btn
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		checkLogin()
//		signOut()
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
		homeContainer.addSubview(logoutButton)
		
		// Container
		NSLayoutConstraint.activate([
			homeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: homeContainer.trailingAnchor, multiplier: 0),
			homeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		// logout button
		NSLayoutConstraint.activate([
			logoutButton.centerYAnchor.constraint(equalTo: homeContainer.centerYAnchor),
			logoutButton.centerXAnchor.constraint(equalTo: homeContainer.centerXAnchor)
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
	@objc func handleLogout() {
		self.signOut()
	}
}

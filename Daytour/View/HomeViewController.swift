import UIKit
import Firebase

class HomeViewController: UIViewController {
	//MARK: - Properties
	
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
		print("Hello Swift")
	}
}

import UIKit
import Firebase

extension UIViewController {
	
	/// 에러 알림창 생성 메소드
	/// - Parameters:
	///   - error: error 인자
	///   - title: 알림창 타이틀
	///   - message: 알림창 내용
	///   - okTitle: 알림창 버튼 타이틀
	func generateErrorAlert(error: Any = "", title: String, message: String = "", okTitle: String) {
		print("Error Log In with \(error)")
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		let okAction = UIAlertAction(title: okTitle, style: .destructive)
		alert.addAction(okAction)
		self.present(alert, animated: true)
	}
	
	
	/// 로그아웃
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
}

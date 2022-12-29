import UIKit
import Firebase

class RegisterViewController: UIViewController {
	//MARK: - Properties
	private let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	private let containerScrollView: UIScrollView = {
		let sv = UIScrollView()
		sv.translatesAutoresizingMaskIntoConstraints = false
		sv.alwaysBounceVertical = true
		sv.isUserInteractionEnabled = true
		return sv
	}()
	private let titleLabel: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Register"
		title.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .bold)
		title.layer.opacity = 0.8
		title.textColor = UIColor.systemBlue
		title.numberOfLines = 0
		title.textAlignment = .center
		return title
	}()
	private let subTitleLabel: UILabel = {
		let subtitle = UILabel()
		subtitle.translatesAutoresizingMaskIntoConstraints = false
		subtitle.text = "Let's join and share your experiences"
		subtitle.textColor = UIColor.gray
		subtitle.layer.opacity = 0.8
		subtitle.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
		subtitle.numberOfLines = 0
		let attrString = NSMutableAttributedString(string: subtitle.text!)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 10
		paragraphStyle.alignment = .center
		attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
		subtitle.attributedText = attrString
		return subtitle
	}()
	private let inputStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 20
		stack.distribution = .fillEqually
		return stack
	}()
	private let usernameContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 15
		view.backgroundColor = .white
		view.layer.masksToBounds = false
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.1
		view.layer.shadowRadius = 10
		view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		return view
	}()
	private let usernameTextField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)])
		tf.borderStyle = .none
		tf.keyboardAppearance = .dark
		tf.autocapitalizationType = .none
		return tf
	}()
	private let passwordContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 15
		view.backgroundColor = .white
		view.layer.masksToBounds = false
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.1
		view.layer.shadowRadius = 10
		view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		return view
	}()
	private let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.borderStyle = .none
		tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)])
		tf.autocapitalizationType = .none
		tf.keyboardAppearance = .dark
		tf.isSecureTextEntry = true
		return tf
	}()
	private let passwordCheckContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 15
		view.backgroundColor = .white
		view.layer.masksToBounds = false
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.1
		view.layer.shadowRadius = 10
		view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		return view
	}()
	private let passwordTextCheckField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.borderStyle = .none
		tf.attributedPlaceholder = NSAttributedString(string: "Password Check", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)])
		tf.autocapitalizationType = .none
		tf.keyboardAppearance = .dark
		tf.isSecureTextEntry = true
		return tf
	}()
	private let genderSegmentedControl: UISegmentedControl = {
		let sc = UISegmentedControl(items: ["Male", "Female"])
		sc.translatesAutoresizingMaskIntoConstraints = false
		sc.backgroundColor = .white
		sc.tintColor = UIColor(white: 1, alpha: 0.87)
		sc.selectedSegmentIndex = 0
		return sc
	}()
	private lazy var RegisterButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Register", for: .normal)
		btn.setTitleColor(UIColor.white, for: .normal)
		btn.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 19, weight: .bold)
		btn.backgroundColor = UIColor(named: "Primary")
		btn.layer.cornerRadius = 15
		btn.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
		return btn
	}()
	private lazy var goToLoginPageButton: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .light), .foregroundColor: UIColor.lightGray])
		attributedTitle.append(NSAttributedString(string: " Log in!", attributes: [.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor(named: "Primary")!]))
		btn.setAttributedTitle(attributedTitle, for: .normal)
		btn.addTarget(self, action: #selector(goToLoginPage), for: .touchUpInside)
		return btn
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		usernameTextField.delegate = self
		passwordTextField.delegate = self
		passwordTextCheckField.delegate = self

		configureNavigationBar()
		configureUI()
		hideKeyboardWhenTap()
	}

}

extension RegisterViewController {
	//MARK: - helper function
	func configureNavigationBar() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.barStyle = .black
	}
	func configureUI() {
		containerView.backgroundColor = .white

		view.addSubview(containerScrollView)
		containerScrollView.addSubview(containerView)
		containerView.addSubview(titleLabel)
		containerView.addSubview(subTitleLabel)
		containerView.addSubview(inputStackView)
		usernameContainer.addSubview(usernameTextField)
		passwordContainer.addSubview(passwordTextField)
		passwordCheckContainer.addSubview(passwordTextCheckField)
		inputStackView.addArrangedSubview(usernameContainer)
		inputStackView.addArrangedSubview(passwordContainer)
		inputStackView.addArrangedSubview(passwordCheckContainer)
		inputStackView.addArrangedSubview(RegisterButton)
		containerView.addSubview(goToLoginPageButton)

		// 스크롤뷰
		NSLayoutConstraint.activate([
			containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerScrollView.topAnchor.constraint(equalTo: view.topAnchor),
			containerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		// 컨테이너뷰
		NSLayoutConstraint.activate([
			containerView.leadingAnchor.constraint(equalTo: containerScrollView.contentLayoutGuide.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: containerScrollView.contentLayoutGuide.trailingAnchor),
			containerView.topAnchor.constraint(equalTo: containerScrollView.contentLayoutGuide.topAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			containerView.widthAnchor.constraint(equalTo: containerScrollView.frameLayoutGuide.widthAnchor)
		])
		// 타이틀 라벨
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: containerView.safeAreaLayoutGuide.topAnchor, multiplier: 7),
			titleLabel.heightAnchor.constraint(equalToConstant: 60),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
		])
		// 서브 타이틀 라벨
		NSLayoutConstraint.activate([
			subTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: subTitleLabel.trailingAnchor, multiplier: 2),
			subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			subTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
			subTitleLabel.heightAnchor.constraint(equalToConstant: 80),
		])
		// 인풋 필드
		NSLayoutConstraint.activate([
			usernameContainer.heightAnchor.constraint(equalToConstant: 60),
			usernameTextField.centerYAnchor.constraint(equalTo: usernameContainer.centerYAnchor),
			usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: usernameContainer.leadingAnchor, multiplier: 2),
			usernameContainer.trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 2),
			passwordTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
			passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordContainer.leadingAnchor, multiplier: 2),
			passwordTextField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -16),
			passwordTextCheckField.centerYAnchor.constraint(equalTo: passwordCheckContainer.centerYAnchor),
			passwordTextCheckField.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordCheckContainer.leadingAnchor, multiplier: 2),
			passwordTextCheckField.trailingAnchor.constraint(equalTo: passwordCheckContainer.trailingAnchor, constant: -16),
			inputStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),
			inputStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: inputStackView.trailingAnchor, multiplier: 2)
		])
		// 로그인 페이지 이동 버튼
		NSLayoutConstraint.activate([
			goToLoginPageButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			goToLoginPageButton.topAnchor.constraint(equalTo: RegisterButton.bottomAnchor, constant: 130)
		])
	}
	func resetInputField() {
		usernameTextField.text = nil
		passwordTextField.text = nil
		passwordTextCheckField.text = nil
	}

	func hideKeyboardWhenTap() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		containerView.addGestureRecognizer(tap)
	}

	//MARK: - Selectors
	// background click dismiss keyboard
	@objc func dismissKeyboard() {
		containerView.endEditing(true)
	}
	// go to login button click
	@objc func goToLoginPage() {
		navigationController?.popViewController(animated: true)
	}
	// Sign Up button click
	@objc func onSignUp() {
		guard let username = usernameTextField.text, usernameTextField.text != "" else {
			self.generateErrorAlert(title: "Fail to sign up", message: "Username cannot be empty.", okTitle: "OK")
			return
		}
		guard let password = passwordTextField.text, passwordTextField.text != "" else {
			self.generateErrorAlert(title: "Fail to sign up", message: "Password cannot be empty.", okTitle: "OK")
			return
		}

		if passwordTextField.text == passwordTextCheckField.text {
			Auth.auth().createUser(withEmail: username, password: password) { result, error in
				if let error = error {
					self.generateErrorAlert(error: error, title: "Fail to sign up", message: "Something went wrong. Please check and try again.", okTitle: "OK")
					self.resetInputField()
					return
				}

				guard let uid = result?.user.uid else { return }
				let accountInfo = ["email": username] as [String: Any]

				Database.database().reference().child("users").child(uid).updateChildValues(accountInfo, withCompletionBlock: { (error, ref) in
					let keyWindow = UIApplication.shared.connectedScenes.filter({ scene in
						scene.activationState == .foregroundActive
					}).map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.filter({
						$0.isKeyWindow
					}).first

					if let homeController = keyWindow?.rootViewController as? HomeViewController { homeController.configureUI() }
					self.dismiss(animated: true)
				})
			}
		} else {
			self.generateErrorAlert(title: "Fail to sign up", message: "Please make sure your passwords match.", okTitle: "OK")
			return
		}
	}
}


//MARK: - text field delegate
extension RegisterViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == usernameTextField, usernameTextField.text != "" {
			passwordTextField.becomeFirstResponder()
		}

		if textField == passwordTextField, usernameTextField.text != "", passwordTextField.text != "" {
			passwordTextCheckField.becomeFirstResponder()
		}

		if textField == passwordTextCheckField, usernameTextField.text != "", passwordTextField.text != "", passwordTextCheckField.text != "" {
			passwordTextCheckField.resignFirstResponder()
			self.onSignUp()
		}
		return true
	}
}

#if DEBUG
	import SwiftUI

	struct MainViewControllerPresentable2: UIViewControllerRepresentable {
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

		}
		func makeUIViewController(context: Context) -> some UIViewController {
			RegisterViewController()
		}
	}

	struct ViewControllerPrepresentable_PreviewProvider2: PreviewProvider {
		static var previews: some View {
			MainViewControllerPresentable2()
				.previewDevice("iphone 12 mini")
				.previewDisplayName("iphone 12 mini")
				.ignoresSafeArea()
		}
	}

#endif

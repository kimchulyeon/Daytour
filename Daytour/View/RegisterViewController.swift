import UIKit
import Firebase

class RegisterViewController: UIViewController {
	///MARK: - Properties
	private let titleLabel: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Sign Up"
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
	private let genderSegmentedControl: UISegmentedControl = {
		let sc = UISegmentedControl(items: ["Male", "Female"])
		sc.backgroundColor = .white
		sc.tintColor = UIColor(white: 1, alpha: 0.87)
		sc.selectedSegmentIndex = 0
		return sc
	}()
	private lazy var emptyContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(genderSegmentedControl)
		genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: genderSegmentedControl.trailingAnchor, multiplier: 1),
			genderSegmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		return view
	}()
	private lazy var RegisterButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign Up", for: .normal)
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
		attributedTitle.append(NSAttributedString(string: " Log in", attributes: [.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor(named: "Primary")!]))
		btn.setAttributedTitle(attributedTitle, for: .normal)
		btn.addTarget(self, action: #selector(goToLoginPage), for: .touchUpInside)
		return btn
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		usernameTextField.delegate = self
		passwordTextField.delegate = self

		configureNavigationBar()
		configureUI()
		hideKeyboardWhenTap()
	}
	

	//MARK: - helper function
	func configureNavigationBar() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.barStyle = .black
	}
	func configureUI() {
		view.backgroundColor = .white

		view.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 7),
			titleLabel.heightAnchor.constraint(equalToConstant: 60),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
		])

		view.addSubview(subTitleLabel)
		NSLayoutConstraint.activate([
			subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: subTitleLabel.trailingAnchor, multiplier: 2),
			subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			subTitleLabel.heightAnchor.constraint(equalToConstant: 80),
		])

		view.addSubview(inputStackView)
		usernameContainer.addSubview(usernameTextField)
		inputStackView.addArrangedSubview(usernameContainer)
		passwordContainer.addSubview(passwordTextField)
		inputStackView.addArrangedSubview(passwordContainer)
		inputStackView.addArrangedSubview(emptyContainer)
		inputStackView.addArrangedSubview(RegisterButton)
		NSLayoutConstraint.activate([
			usernameContainer.heightAnchor.constraint(equalToConstant: 60),

			usernameTextField.centerYAnchor.constraint(equalTo: usernameContainer.centerYAnchor),
			usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: usernameContainer.leadingAnchor, multiplier: 2),
			usernameContainer.trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 2),
			passwordTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
			passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordContainer.leadingAnchor, multiplier: 2),
			passwordContainer.trailingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 2),

			inputStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 50),
			inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: inputStackView.trailingAnchor, multiplier: 2)
		])
		
		view.addSubview(goToLoginPageButton)
		NSLayoutConstraint.activate([
			goToLoginPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			goToLoginPageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
		])

	}

	func hideKeyboardWhenTap() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
}

//MARK: - Selectors
extension RegisterViewController {
	// background click dismiss keyboard
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	// Register button click
	@objc func onClickRegister() {
		print("register click::::::")
	}
	// go to login button click
	@objc func goToLoginPage() {
		navigationController?.popViewController(animated: true)
	}
	// Sign Up button click
	@objc func onSignUp() {
		guard let username = usernameTextField.text, usernameTextField.text != "" else { return }
		guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
		let genderType = genderSegmentedControl.selectedSegmentIndex

		Auth.auth().createUser(withEmail: username, password: password) { result, error in
			if let error = error {
				print("Fail to Sign Up with \(error)")
				return
			}

			guard let uid = result?.user.uid else { return }
			let accountInfo = ["email": username, "genderType": genderType] as [String: Any]

			Database.database().reference().child("users").child(uid).updateChildValues(accountInfo) { error, ref in
				let keyWindow = UIApplication.shared.connectedScenes.filter({ scene in
					scene.activationState == .foregroundActive
				}).map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.filter({
					$0.isKeyWindow
				}).first

				if let homeController = keyWindow?.rootViewController as? HomeViewController { homeController.configureUI() }
				self.dismiss(animated: true)
			}
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
			print("회원가입!!!!!!!!!!!!!!")
			passwordTextField.resignFirstResponder()
			onSignUp()
		}
		return true
	}
}


import UIKit

class RegisterViewController: UIViewController {
	//MARK: - Properties
	private let titleLabel: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Pleasure to meet you!"
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
		subtitle.text = "Join us and share your experiences!"
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
	private let emptyContainer: UIView = {
		let view = UIView()
		return view
	}()
	private let RegisterButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Register", for: .normal)
		btn.setTitleColor(UIColor.white, for: .normal)
		btn.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 19, weight: .bold)
		btn.backgroundColor = UIColor(named: "Primary")
		btn.layer.cornerRadius = 15
		return btn
	}()
	private let goToLoginPageButton: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		let attributedTitle = NSMutableAttributedString(string: "Already joinned? ", attributes: [.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .light), .foregroundColor: UIColor.lightGray])
		attributedTitle.append(NSAttributedString(string: " Log in", attributes: [.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor(named: "Primary")!]))
		btn.setAttributedTitle(attributedTitle, for: .normal)
		return btn
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		print("hello")
		configureUI()
		hideKeyboardWhenTap()
	}

	//MARK: - helper function
	func configureUI() {
		view.translatesAutoresizingMaskIntoConstraints = false
		// title label
		view.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
			titleLabel.heightAnchor.constraint(equalToConstant: 60),
		])
		// subtitle label
		view.addSubview(subTitleLabel)
		NSLayoutConstraint.activate([
			subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: subTitleLabel.trailingAnchor, multiplier: 2),
			subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			subTitleLabel.heightAnchor.constraint(equalToConstant: 80),
		])
		// input field stack view
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
			usernameTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: usernameContainer.trailingAnchor, multiplier: 2),
			passwordTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
			passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordContainer.leadingAnchor, multiplier: 2),
			passwordTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: passwordContainer.trailingAnchor, multiplier: 2),

			inputStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 50),
			inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: inputStackView.trailingAnchor, multiplier: 2)
		])
		// login page button
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
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}



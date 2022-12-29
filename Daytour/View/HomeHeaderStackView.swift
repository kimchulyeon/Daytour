import UIKit

protocol HomeHeaderStackViewDelegate: AnyObject {
	func clickProfileImage()
}

class HomeHeaderStackView: UIStackView {

	weak var delegate: HomeHeaderStackViewDelegate?

	//MARK: - Properties
	let titleStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .equalSpacing
		stack.axis = .vertical
		return stack
	}()
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Welcome!"
		label.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .bold)
		label.layer.opacity = 0.5
		label.textColor = UIColor(named: "Title")
		return label
	}()
	let nicknameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "user"
		label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .bold)
		label.textColor = UIColor(named: "Primary")
		return label
	}()
	lazy var profileImgButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
		btn.imageView?.contentMode = .scaleAspectFit
		btn.tintColor = UIColor(named: "Secondary")
		btn.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .regular, scale: .default), forImageIn: .normal)
		btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
		return btn
	}()

	//MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)

		translatesAutoresizingMaskIntoConstraints = false
		distribution = .equalCentering
		isLayoutMarginsRelativeArrangement = true
		layoutMargins = .init(top: 15, left: 20, bottom: 0, right: 20)

		[titleLabel, nicknameLabel].forEach { view in
			titleStackView.addArrangedSubview(view)
		}
		[titleStackView, profileImgButton].forEach { view in
			addArrangedSubview(view)
		}
	}

	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
}

extension HomeHeaderStackView {
	//MARK: - selector
	@objc func logout() {
		delegate?.clickProfileImage()
	}
}

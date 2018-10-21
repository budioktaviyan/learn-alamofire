import UIKit

protocol LoadingErrorDelegate {

    func onRetryClicked()
}

open class LoadingErrorView: UIView {

    var delegate: LoadingErrorDelegate?

    fileprivate lazy var content: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 8

        return view
    }()

    fileprivate lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.text = "Koneksi gagal"
        view.textColor = .black
        view.textAlignment = .center

        return view
    }()

    fileprivate lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Coba lagi", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onRetryClicked), for: .touchUpInside)

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func onRetryClicked() {
        self.delegate?.onRetryClicked()
    }

    fileprivate func initView() {
        content.addArrangedSubview(label)
        content.addArrangedSubview(button)
        addSubview(content)

        content.anchorCenterSuperview()
    }
}

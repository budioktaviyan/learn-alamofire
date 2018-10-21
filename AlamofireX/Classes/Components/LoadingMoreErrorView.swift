import UIKit

protocol LoadingMoreErrorDelegate {

    func onRetryMoreClicked()
}

open class LoadingMoreErrorView: DatasourceCell {

    var delegate: LoadingMoreErrorDelegate?

    fileprivate lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Coba lagi", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onRetryMoreClicked), for: .touchUpInside)

        return view
    }()

    @objc open func onRetryMoreClicked() {
        self.delegate?.onRetryMoreClicked()
    }

    override open func setupViews() {
        addSubview(button)
        button.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}

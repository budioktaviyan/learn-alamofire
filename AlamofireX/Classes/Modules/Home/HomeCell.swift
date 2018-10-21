import UIKit

class HomeCell: DatasourceCell {

    fileprivate lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .black
        view.textAlignment = .left

        return view
    }()

    fileprivate lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? HomeResponse.Result else { return }
            guard let title = data.title else { return }
            label.text = title
        }
    }

    override func setupViews() {
        backgroundColor = .white
        addSubview(label)
        addSubview(separator)

        label.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 8,
            leftConstant: 16,
            bottomConstant: 0,
            rightConstant: 16,
            widthConstant: 0,
            heightConstant: 0
        )

        separator.anchor(
            label.bottomAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 8,
            leftConstant: 16,
            bottomConstant: 0,
            rightConstant: 16,
            widthConstant: 0,
            heightConstant: 0.5
        )
    }
}

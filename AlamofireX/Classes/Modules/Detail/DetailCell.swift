import UIKit
import Kingfisher

class DetailHeaderCell: DatasourceCell {

    fileprivate lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? DetailResponse else { return }
            guard let image = data.backdrop_path else { return }
            loadImage(url: image)
        }
    }

    override func setupViews() {
        addSubview(image)
        image.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }

    fileprivate func loadImage(url: String) {
        let imageUrl = URL(string: url)
        image.kf.setImage(
            with: imageUrl,
            placeholder: nil,
            options: nil,
            progressBlock: nil,
            completionHandler: { image, error, cacheType, imageUrl in
                guard let image = image else { return }
                self.image.image = UIImage.resize(image: image, targetSize: CGSize(width: self.contentView.frame.width, height: 256))
        })
    }
}

class DetailCell: DatasourceCell {

    fileprivate lazy var text: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.sizeToFit()

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? DetailResponse else { return }
            guard let text = data.overview else { return }
            self.text.text = text
        }
    }

    override func setupViews() {
        backgroundColor = .white
        addSubview(text)
        text.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: -24,
            leftConstant: 8,
            bottomConstant: 0,
            rightConstant: 8,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}

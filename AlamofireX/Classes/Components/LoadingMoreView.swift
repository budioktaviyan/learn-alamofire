import UIKit

open class LoadingMoreView: DatasourceCell {

    open lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.hidesWhenStopped = true

        return view
    }()

    open override func setupViews() {
        addSubview(indicator)
        indicator.anchorCenterSuperview()
    }
}

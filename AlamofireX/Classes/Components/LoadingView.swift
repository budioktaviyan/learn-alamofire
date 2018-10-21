import UIKit

open class LoadingView: UIView {

    fileprivate lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.hidesWhenStopped = true

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func show() {
        indicator.startAnimating()
    }

    open func hide() {
        indicator.stopAnimating()
        self.removeFromSuperview()
    }

    fileprivate func initView() {
        addSubview(indicator)
        indicator.anchorCenterSuperview()
    }
}

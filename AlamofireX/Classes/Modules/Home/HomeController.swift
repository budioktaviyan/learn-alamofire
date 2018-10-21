import UIKit

class HomeController: DatasourceController {

    fileprivate lazy var params: HomeParam = HomeParam()
    fileprivate lazy var datasources: HomeDatasource = HomeDatasource()
    fileprivate lazy var loadView: LoadingView = LoadingView()
    fileprivate lazy var loadErrorView: LoadingErrorView = {
        let view = LoadingErrorView()
        view.delegate = self

        return view
    }()

    override func viewDidLoad() {
        self.title = "Home"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: UIBarButtonItemStyle.plain,
            target: nil,
            action: nil
        )
        self.collectionView?.backgroundColor = .white
        self.datasource = datasources
        self.showLoading()
    }
}

extension HomeController: LoadingErrorDelegate, LoadingMoreErrorDelegate {

    func onRetryClicked() {
        hideLoadingError()
    }

    func onRetryMoreClicked() {}

    fileprivate func showLoading() {
        initLoadView()
        loadView.show()
    }

    fileprivate func hideLoading() {
        loadView.hide()
    }

    fileprivate func initLoadView() {
        view.addSubview(loadView)
        loadView.anchor(
            view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }

    fileprivate func showLoadingError() {
        initLoadErrorView()
        loadErrorView.isHidden = false
    }

    fileprivate func hideLoadingError() {
        loadErrorView.isHidden = true
        loadErrorView.removeFromSuperview()
    }

    fileprivate func initLoadErrorView() {
        view.addSubview(loadErrorView)
        loadErrorView.anchor(
            view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}

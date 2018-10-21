import UIKit

class HomeController: DatasourceController {

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
    }
}

extension HomeController: LoadingErrorDelegate, LoadingMoreErrorDelegate {

    func onRetryClicked() {
        loadErrorView.isHidden = true
    }

    func onRetryMoreClicked() {}
}

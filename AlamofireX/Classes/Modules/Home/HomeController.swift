import UIKit
import Alamofire

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
        self.discoverMovie()
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeController: LoadingErrorDelegate, LoadingMoreErrorDelegate {

    func onRetryClicked() {
        hideLoadingError()
        discoverMovie()
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

extension HomeController {

    fileprivate func discoverMovie() {
        showLoading()

        // Making a network call
        let url = AppConfig.Api.BaseURL + AppConfig.Module.Discover
        let headers: HTTPHeaders = ["Accept": "application/json"]
        Alamofire.request(
            url,
            method: .get,
            parameters: params.request.nullKeyRemoval(),
            encoding: URLEncoding(),
            headers: headers).responseData { response in
                let decoder = JSONDecoder()
                let data: Result<HomeResponse> = decoder.decodeResponse(from: response)

                // Decode response into model
                guard let model = data.value else {
                    self.hideLoading()
                    self.showLoadingError()

                    return
                }
                self.datasources.objects = model.results
                self.reloadData()
                self.hideLoading()
        }
    }

    fileprivate func reloadData() {
        collectionView?.reloadData()
    }
}

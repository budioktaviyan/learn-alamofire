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

    fileprivate var isLoading: Bool = false
    fileprivate var isLoadMore: Bool = false
    fileprivate var currentPage: Int64 = 0 { didSet {self.checkCurrentPage()} }
    fileprivate var totalPage: Int64 = 0

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch isLoadMore {
        case false:
            return CGSize(width: view.frame.width, height: 0)
        default:
            return CGSize(width: view.frame.width, height: 50)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        switch elementKind {
        case UICollectionElementKindSectionFooter:
            switch datasources.isLoadMoreError {
            case false:
                guard let view = view as? LoadingMoreView else { return }
                view.indicator.startAnimating()
            default:
                guard let view = view as? LoadingMoreErrorView else { return }
                view.delegate = self
            }
        default:
            break
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let objects = datasources.objects else { return }
        guard let data = objects[indexPath.row] as? HomeResponse.Result else { return }

        let url = AppConfig.Api.ImageURL
        let model = DetailResponse(
            title: data.title,
            overview: data.overview,
            backdrop_path: "\(url)\(data.backdrop_path ?? "")"
        )
        AppRouter.sharedInstance.presentView(viewController: DetailController(model: model))
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (currentOffsetY == maximumOffset) && currentPage + 1 <= totalPage && !isLoading { self.discoverMoreMovie() }
    }
}

extension HomeController: LoadingErrorDelegate, LoadingMoreErrorDelegate {

    func onRetryClicked() {
        hideLoadingError()
        discoverMovie()
    }

    func onRetryMoreClicked() {
        datasources.isLoadMoreError = false
        reloadData()
        discoverMoreMovie()
    }

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
                guard let total = model.total_pages else { return }

                self.datasources.objects = model.results
                self.totalPage = total
                self.currentPage = 1
                self.reloadData()
                self.hideLoading()
        }
    }

    fileprivate func discoverMoreMovie() {
        isLoading = true
        params.page = currentPage + 1

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
                    self.datasources.isLoadMoreError = true
                    self.reloadData()

                    return
                }

                guard let total = model.results?.count else { return }
                switch total {
                case _ where total > 0:
                    self.datasources.isLoadMoreError = false
                    let _ = model.results?.compactMap { element in self.datasources.objects?.append(element) }
                default: break
                }

                self.isLoading = false
                self.currentPage += 1
                self.reloadData()
        }
    }

    fileprivate func checkCurrentPage() {
        isLoadMore = currentPage < totalPage
    }

    fileprivate func reloadData() {
        collectionView?.reloadData()
    }
}

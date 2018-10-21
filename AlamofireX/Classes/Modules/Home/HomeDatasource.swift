import UIKit

class HomeDatasource: Datasource {

    var isLoadMoreError: Bool = false

    override func numberOfItems(_ section: Int) -> Int {
        return objects?.count ?? 0
    }

    override func item(_ indexPath: IndexPath) -> Any? {
        return objects?[indexPath.item]
    }

    override func cellClasses() -> [DatasourceCell.Type] {
        return [HomeCell.self]
    }

    override func cellClass(_ indexPath: IndexPath) -> DatasourceCell.Type? {
        return HomeCell.self
    }

    override func footerClasses() -> [DatasourceCell.Type]? {
        switch isLoadMoreError {
        case false:
            return [LoadingMoreView.self, LoadingMoreErrorView.self]
        default:
            return [LoadingMoreErrorView.self, LoadingMoreView.self]
        }
    }
}

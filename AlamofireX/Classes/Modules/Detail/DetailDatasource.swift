import UIKit

class DetailDatasource: Datasource {

    var model: DetailResponse?

    override func numberOfItems(_ section: Int) -> Int {
        return objects?.count ?? 1
    }

    override func headerItem(_ section: Int) -> Any? {
        return model ?? nil
    }

    override func item(_ indexPath: IndexPath) -> Any? {
        return objects?[indexPath.row]
    }

    override func headerClasses() -> [DatasourceCell.Type]? {
        return [DetailHeaderCell.self]
    }

    override func cellClasses() -> [DatasourceCell.Type] {
        return [DetailCell.self]
    }

    override func cellClass(_ indexPath: IndexPath) -> DatasourceCell.Type? {
        return DetailCell.self
    }
}

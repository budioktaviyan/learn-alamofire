import UIKit

protocol AppRouterDelegate {

    func presentView(viewController: UIViewController)
}

class AppRouter: AppRouterDelegate {

    static let sharedInstance = AppRouter.createAppRouter()

    fileprivate var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func presentView(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    fileprivate static func createAppRouter() -> AppRouter {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        let router = AppRouter(navigationController: rootVC)

        return router
    }
}

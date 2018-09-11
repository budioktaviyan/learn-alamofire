import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        self.title = "Home"
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: UIBarButtonItemStyle.plain,
            target: nil,
            action: nil
        )
    }
}

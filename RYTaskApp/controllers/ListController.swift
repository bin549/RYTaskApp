import UIKit

class ListController: UIViewController {
    let header = GDHeaderView(title: "Stuff to get done", subtitle: "4 left")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(header)
    }
}

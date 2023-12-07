import Foundation
import UIKit

class MemberViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    var member: ConfigItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = member?.a

    }
}

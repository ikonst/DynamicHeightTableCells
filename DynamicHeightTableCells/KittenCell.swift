import UIKit

class KittenModel {
    var isExpanded: Bool = false
}

class KittenCell: DynamicHeightCell {

    @IBOutlet var heightConstraint: NSLayoutConstraint!

    var model: KittenModel! {
        didSet {
            self.updateExpanded()
        }
    }

    func updateExpanded() {
        if let model = model {
            self.heightConstraint?.priority = UILayoutPriorityRequired - 1
            self.heightConstraint?.constant = model.isExpanded ? 200 : 100
        }
    }

    @IBAction func kittenTapped(sender: AnyObject) {
        self.model.isExpanded = !self.model.isExpanded
        self.updateExpanded()
        self.heightChangedClosure?()
    }
}

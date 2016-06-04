import UIKit

class ViewController: UITableViewController {

    private var kittenModels: [NSIndexPath: KittenModel] = [:]

    private var textModels: [NSIndexPath: TextModel] = [:]

    override func viewDidLoad() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
    }

    // MARK: Table data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = indexPath.row % 2 == 0 ? "kittenCell" : "textCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        if let cell = cell as? DynamicHeightCell {
            cell.heightChangedClosure = { [weak self] in
                self?.cellHeightDidChange()
            }
        }

        if let cell = cell as? TextCell {
            let model = textModels[indexPath] ?? TextModel()
            cell.model = model
            textModels[indexPath] = model
        }

        if let cell = cell as? KittenCell {
            let model = kittenModels[indexPath] ?? KittenModel()
            cell.model = model
            kittenModels[indexPath] = model
        }

        return cell
    }

    // MARK: Handler for cell height change

    func cellHeightDidChange() {
        UIView.animateWithDuration(0.2) {
            var oldHeights: [UITableViewCell: CGFloat] = [:]
            for cell in self.tableView.visibleCells {
                oldHeights[cell] = cell.bounds.height
            }

            let previousContentOffset = self.tableView.contentOffset

            self.tableView.beginUpdates()
            self.tableView.endUpdates()

            // UITableView keeps only visible cells as its subviews.
            // Cells that were just added as subviews won't animate properly since they're added
            // with their final frame. We need to "animate them in" ourselves (as if they came from their
            // "off-screen frame").
            var accumulatedOffset: CGFloat = 0
            for cell in self.tableView.visibleCells {
                if let oldHeight = oldHeights[cell] { // pre-existing cell
                    accumulatedOffset += cell.bounds.height - oldHeight
                    print("At \(cell.dynamicType) \(cell.frame.origin.y) + \(cell.frame.height), adding to \(accumulatedOffset) offset")
                } else { // newly added cell
                    print("At \(cell.dynamicType) \(cell.frame.origin.y) + \(cell.frame.height), moving by \(-accumulatedOffset) then animating")
                    cell.layer.removeAllAnimations() // sometimes UIKit already does stupid things
                    UIView.performWithoutAnimation {
                        cell.frame.offsetInPlace(dx: 0, dy: -accumulatedOffset) // where it would've been before update
                    }
                    cell.frame.offsetInPlace(dx: 0, dy: accumulatedOffset) // allow it to animate as if it existed
                }
            }

            print("---")

            self.tableView.contentOffset = previousContentOffset
        }
    }
}


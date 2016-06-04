import UIKit

class TextModel {
    var text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu dolor a neque euismod ornare eu laoreet est. Quisque facilisis turpis vitae tellus aliquet mollis. Nunc eleifend, sem non sollicitudin rutrum, lectus augue porta quam, vel tempor velit turpis a risus. Duis ante nunc, pretium vel urna id, rhoncus pretium sem. Sed libero nulla, ornare nec scelerisque eget, aliquam sit amet ipsum. Donec sed odio lobortis, blandit libero eget, porta tortor. Donec viverra ornare porttitor. In turpis lacus, vestibulum vitae vestibulum quis, bibendum eget felis. Curabitur eu condimentum enim, bibendum vehicula eros. Mauris imperdiet in tellus vitae lacinia. Integer ullamcorper arcu non mauris egestas, id pulvinar lorem iaculis. Sed rutrum dolor quis nisi sagittis lacinia. Curabitur aliquet mattis lectus. Pellentesque in rhoncus nunc, sit amet tempus odio."
}

class TextCell: DynamicHeightCell, UITextViewDelegate {

    @IBOutlet private var textView: UITextView!

    private var lastHeight: CGFloat = 0

    var model: TextModel? {
        didSet {
            self.textView?.text = self.model?.text
        }
    }

    func textViewDidChange(textView: UITextView) {
        self.model?.text = textView.text

        let intrinsicHeight = textView.intrinsicContentSize().height
        if intrinsicHeight != self.lastHeight {
            print("Text height changed from \(self.lastHeight) to \(intrinsicHeight)")
            self.lastHeight = intrinsicHeight
            self.heightChangedClosure?()
        }
    }
}

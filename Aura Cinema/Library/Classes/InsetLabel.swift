import UIKit

final class InsetLabel: UILabel {
    
    var insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    var topSpace: CGFloat {
        set { insets.top = newValue }
        get { return insets.top }
    }
    
    var rightSpace: CGFloat {
        set { insets.right = newValue }
        get { return insets.right }
    }
    
    var bottomSpace: CGFloat {
        set { insets.bottom = newValue }
        get { return insets.bottom }
    }
    
    var leftSpace: CGFloat {
        set { insets.left = newValue }
        get { return insets.left }
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(
            top: -insets.top,
            left: -insets.left,
            bottom: -insets.bottom,
            right: -insets.right
        )
        return textRect.inset(by: invertedInsets)
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
}

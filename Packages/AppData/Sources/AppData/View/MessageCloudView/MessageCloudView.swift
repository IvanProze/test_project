import UIKit
import AppResource

final class MessageCloudView: UIView {
    let tailEnd: CGPoint
    let referenceView: UIView
    let color: CGColor
    let radius: CGFloat
    private var tailLayer: CAShapeLayer?

    init(tailEnd: CGPoint, referenceView: UIView, color: CGColor) {
        self.tailEnd = tailEnd
        self.referenceView = referenceView
        self.color = color
        self.radius = referenceView.layer.cornerRadius
        super.init(frame: referenceView.frame)
        backgroundColor = .clear
        clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let parent = superview else { return }
        
        let bubbleRect = referenceView.frame
        let combinedPath = UIBezierPath(roundedRect: bubbleRect, cornerRadius: radius)
        
        let startPoint = self.convert(CGPoint(x: bounds.maxX - radius, y: bounds.maxY - 3), to: parent)
        let startPoint2 = self.convert(CGPoint(x: bounds.maxX - 12 - radius, y: bounds.maxY - 8), to: parent)

        let tailPath = UIBezierPath()
        tailPath.move(to: startPoint)
        tailPath.addLine(to: tailEnd)
        tailPath.addLine(to: startPoint2)
        tailPath.close()
        
        combinedPath.append(tailPath)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = combinedPath.cgPath
        lineLayer.fillColor = color
        lineLayer.strokeColor = UIColor.clear.cgColor
        lineLayer.lineWidth = 1
        
        lineLayer.shadowColor = Colors.shadow.cgColor
        lineLayer.shadowOpacity = 0.15
        lineLayer.shadowOffset = CGSize(width: 0, height: 4)
        lineLayer.shadowRadius = 4
        lineLayer.shadowPath = combinedPath.cgPath
        
        tailLayer = lineLayer
        parent.layer.insertSublayer(lineLayer, below: referenceView.layer)
    }
    
    func hideTail() {
        isHidden = true
        tailLayer?.isHidden = true
    }
    
    func showTail() {
        isHidden = false
        tailLayer?.isHidden = false
    }
}

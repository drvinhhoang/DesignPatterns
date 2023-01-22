import UIKit
import PlaygroundSupport

// component

protocol Shape {
   func draw() -> CAShapeLayer
}

class Rectangle: Shape {
    var frame: CGRect
    
    init(frame: CGRect) {
        self.frame = frame
    }
    
    func draw() -> CAShapeLayer {
        let drect = CGRect(x: (frame.width * 0.25),
                           y: (frame.height * 0.25),
                           width: (frame.width * 0.5),
                           height: (frame.height * 0.5))
        let bpath: UIBezierPath = UIBezierPath(rect: drect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bpath.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
        return shapeLayer
    }
}

// concrete component
class Circle: Shape {
    var arcCenter: CGPoint
    var radius: CGFloat
    
    init(arcCenter: CGPoint, radius: CGFloat) {
        self.arcCenter = arcCenter
        self.radius = radius
    }
    
    func draw() -> CAShapeLayer {
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.blue.cgColor
        return shapeLayer
    }
}


// decorator protocol
protocol ShapeDecorator: Shape {
    var shape: Shape { get set }
    
    func draw() -> CAShapeLayer
}


// concrete decorator
class AddBorderDecorator: ShapeDecorator {
    var shape: Shape
    
    init(shape: Shape) {
        self.shape = shape
    }
    
    func draw() -> CAShapeLayer {
        let view = shape.draw()
        view.strokeColor = UIColor.black.cgColor
        view.lineWidth = 1
        return view
    }
}

class AddShadowDecorator: ShapeDecorator {
    var shape: Shape
    
    var radius: CGFloat
    
    init(shape: Shape, radius: CGFloat) {
        self.shape = shape
        self.radius  = radius
    }
    
    func draw() -> CAShapeLayer {
        let view = shape.draw()
        view.shadowRadius = radius
        view.shadowOpacity = 0.8
        view.shadowColor = UIColor.black.cgColor
        view.shadowOffset = CGSize(width: 0, height: radius / 2)
        view.masksToBounds = false
        return view
    }
}

class AddConnerRadiusDecorator: ShapeDecorator {
    var shape: Shape
    
    var radius: CGFloat
    
    init(shape: Shape, radius: CGFloat) {
        self.shape = shape
        self.radius  = radius
    }
    
    func draw() -> CAShapeLayer {
        let view = shape.draw()
        view.cornerRadius = radius
        return view
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let rectagle = Rectangle(frame: CGRect(x: 200, y: 100, width: 200, height: 100))
        let addBorderDecoratorRectangle = AddBorderDecorator(shape: rectagle)
        let addShadowDecoratorRectangle = AddShadowDecorator(shape: addBorderDecoratorRectangle, radius: 10)
        
        let circle = Circle(arcCenter: CGPoint(x: 200, y: 300), radius: 100)
        let addShadowDecoratorCircle = AddShadowDecorator(shape: circle, radius: 10)
        
        
        
        view.layer.addSublayer(addShadowDecoratorRectangle.draw())
        
        view.layer.addSublayer(addShadowDecoratorCircle.draw())
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

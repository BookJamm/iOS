//
//  ViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/08.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {

    // MARK: Variables

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
    }
    
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
            // .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    public struct UIViewPreview<View: UIView>: UIViewRepresentable {
        public let view: View
        public init(_ builder: @escaping () -> View) {
            view = builder()
        }
        // MARK: - UIViewRepresentable
        public func makeUIView(context: Context) -> UIView {
            return view
        }
        public func updateUIView(_ view: UIView, context: Context) {
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
    }

    public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
        public let viewController: ViewController

        public init(_ builder: @escaping () -> ViewController) {
            viewController = builder()
        }

        // MARK: - UIViewControllerRepresentable
        public func makeUIViewController(context: Context) -> ViewController {
            viewController
        }

        @available(iOS 13.0, tvOS 13.0, *)
        @available(OSX, unavailable)
        @available(watchOS, unavailable)
        public func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
            return
        }
    }
#endif

extension UIImage {
    func circularImage() -> UIImage? {
        let shorterSide = UIImage(named: "BasicProfile")?.size.width
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: shorterSide!, height: shorterSide!))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = shorterSide! / 2.0
        imageView.layer.masksToBounds = true
        imageView.image = self

        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        imageView.layer.render(in: context)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
}


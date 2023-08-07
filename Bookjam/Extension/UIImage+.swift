//
//  UIImage+.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/07.
//

import UIKit


// MARK: 이미지 구형으로 만들어 주는 extension
// circularImage() 호출해서 사용함

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

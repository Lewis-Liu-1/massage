//
//  Extensions.swift
//  NewMassage
//
//  Created by Lewis Liu on 11/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    public var width: CGFloat{
        return self.frame.size.width
    }
    public var height: CGFloat{
        return self.frame.size.height;
    }
    public var top: CGFloat{
        return self.frame.origin.y;
    }
    public var bottom: CGFloat{
        return self.frame.size.height+self.frame.origin.y;
    }
    public var left: CGFloat{
        return self.frame.origin.x;
    }
    public var right: CGFloat{
        return self.frame.origin.x + self.frame.size.width;
    }

}

extension UIButton
{
    /*
     Add right arrow disclosure indicator to the button with normal and
     highlighted colors for the title text and the image
     */
    func disclosureButton(baseColor:UIColor)
    {
        //self.setTitleColor(baseColor, for: .normal)
        //self.setTitleColor(baseColor.withAlphaComponent(0.3), for: .highlighted)
        
        guard let image = UIImage(named: "bigger")?.withRenderingMode(.alwaysTemplate) else
        {
            return
        }
        guard let imageHighlight = UIImage(named: "bigger")?.alpha(0.3)?.withRenderingMode(.alwaysTemplate) else
        {
            return
        }
        
        self.imageView?.contentMode = .scaleAspectFit
        
        self.setImage(image, for: .normal)
        //self.setImage(imageHighlight, for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.bounds.size.width-image.size.width*1.5, bottom: 0, right: 0);
        self.layer.borderWidth = 0.5
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 0,bottom: 10,right: 0)
       
        //self.backgroundColor = .lightGray
    }
    
}
extension UIImage {
    func alpha(_ value:CGFloat)->UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UITabBarController {

    // Create a view controller and setup it's tab bar item with a title and image
    func viewControllerWithTabTitle(_ title: String, image image: UIImage) -> UIViewController {
        var viewController: UIViewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        return viewController
    }

    // Create a custom UIButton and add it to the center of our tab bar
    func addCenterButtonWithImage(_ buttonImage: UIImage, highlightImage highlightImage: UIImage) {
        var button: UIButton = UIButton(type: .custom)
        button.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
        button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)
        button.setBackgroundImage(buttonImage, for:  .normal)
        button.setBackgroundImage(highlightImage, for: .highlighted)
        var heightDifference: CGFloat = buttonImage.size.height-self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center
        } else {
            var center: CGPoint = self.tabBar.center
            center.y = center.y-heightDifference/2.0
            button.center = center

        }
        self.view.addSubview(button)
    }

    func shouldAutorotate(_ interfaceOrientation: UIInterfaceOrientation) -> Bool {
        return true
    }

}


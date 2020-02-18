//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit

class InstagramViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ self.viewControllerWithTabTitle("Feed", image: UIImage(named: "112-group.png")!),self.viewControllerWithTabTitle("Popular", image: UIImage(named: "29-heart.png")!),self.viewControllerWithTabTitle("Share", image: UIImage(named: "news.png")!),self.viewControllerWithTabTitle("News", image: UIImage(named: "news.png")!),self.viewControllerWithTabTitle("@user", image: UIImage(named: "123-id-card.png")!)]
    }

    func willAppearIn(_ navigationController: UINavigationController) {
        self.addCenterButtonWithImage(UIImage(named: "cameraTabBarItem.png")!,highlightImage: UIImage(named: "cameraTabBarItem.png")!)
    }

}


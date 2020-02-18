//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit

class PathViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ self.viewControllerWithTabTitle("Today", image: UIImage(named: "tab-today.png")!),self.viewControllerWithTabTitle("Explore", image: UIImage(named: "tab-explore")!),self.viewControllerWithTabTitle("", image: UIImage(named: "tab-friends.png")!),self.viewControllerWithTabTitle("Friends", image: UIImage(named: "tab-friends.png")!),self.viewControllerWithTabTitle("Me", image: UIImage(named: "tab-me.png")!)]
    }

    func willAppearIn(_ navigationController: UINavigationController) {
        self.addCenterButtonWithImage(UIImage(named: "capture-button.png")!, highlightImage: UIImage(named: "capture-button.png")!)
    }

}


//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit
//import BaseViewController

class DailyBoothViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [self.viewControllerWithTabTitle("Home", image: UIImage(named: "tab_feed.png")!),self.viewControllerWithTabTitle("Live", image: UIImage(named: "tab_live")!),self.viewControllerWithTabTitle("", image: UIImage(named: "tab_feed_profile.png")!),self.viewControllerWithTabTitle("Profile", image: UIImage(named: "tab_feed_profile.png")!),self.viewControllerWithTabTitle("Messages", image: UIImage(named: "tab_messages.png")!)]
    }

    func willAppearIn(_ navigationController: UINavigationController) {
        self.addCenterButtonWithImage(UIImage(named: "camera_button_take.png")!, highlightImage: UIImage(named: "tabBar_cameraButton_ready_matte.png")!)
    }

}


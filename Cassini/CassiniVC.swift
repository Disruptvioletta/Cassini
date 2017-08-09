//
//  CassiniVC.swift
//  Cassini
//
//  Created by Illarionova Violetta on 20/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import UIKit

class CassiniVC: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            if let imageV = (segue.destination.contents as? ImageViewController) {
                imageV.imageURL = url
                imageV.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    

}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}

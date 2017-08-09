//
//  ImageViewController.swift
//  Cassini
//
//  Created by Illarionova Violetta on 20/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController  {
    
    //MARK: Model

    var imageURL : URL? {
        didSet {
            image = nil
            if view.window != nil { // if we are on screen - then fetch image
                fetchImage()
            }
        }
    }
    // MARK:  Outlet
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    // MARK: Private implementation
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, url == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
//    MARK: Navigation controller lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }

    
    // MARK: User Interface
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            // to zoom we have to handle viewForZooming(in scrollView:)
            scrollView.delegate = self
            // and we must set our minimum and maximum zoom scale
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            // most important thing to set in UIScrollView is contentSize
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
            
        }
    }
    
    
    
    fileprivate var  imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}

// MARK: UIScrollViewDelegate 
// Extension which makes ImageViewController conform to UIScrollViewDelegate
// Handles viewForZooming(in scrollView:)
// by returning the UIImageView as the view to transform when zooming

extension ImageViewController : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var originalImage: UIImage?
    var filteredImage: UIImage?
    var imageProcessor: ImageProcessor?
    var isFiltered: Bool = false
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        imageProcessor = ImageProcessor()
        compareButton.enabled = false
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        lpgr.minimumPressDuration = 0.1
        imageView.addGestureRecognizer(lpgr)
        imageView.userInteractionEnabled = true
    }
    
    func longPressed(recognizer: UILongPressGestureRecognizer) {
        if (originalImage != nil && filteredImage != nil) {
            if recognizer.state == UIGestureRecognizerState.Began {
                imageView.image = originalImage
            }
            if recognizer.state == UIGestureRecognizerState.Ended {
                imageView.image = filteredImage
            }
        }
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func filterImage(apply: String) {
        let current: UIImage
        if originalImage == nil {
            originalImage = imageView.image!
            current = originalImage!
        } else {
            current = filteredImage!
        }
        let rgba = RGBAImage(image: current)!
        let filtered = imageProcessor!.predefined(rgba, filter: apply)
        filteredImage = filtered.toUIImage()
        imageView.image = filteredImage
        isFiltered = true
        compareButton.enabled = true
    }
    
    @IBAction func onBoostRed(sender: AnyObject) {
        filterImage("boost-red")
    }
    
    @IBAction func onBoostGreen(sender: AnyObject) {
        filterImage("boost-green")
    }

    @IBAction func onBoostBlue(sender: AnyObject) {
        filterImage("boost-blue")
    }
    
    @IBAction func onDarken(sender: AnyObject) {
        filterImage("darken")
    }
    
    @IBAction func onBrighten(sender: AnyObject) {
        filterImage("brighten")
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if (isFiltered) {
            if originalImage != nil {
                // only something to compare if a filter was applied
                imageView.image = originalImage
            }
            isFiltered = false
        } else {
            if filteredImage != nil {
                // only something to compare if a filter was applied
                imageView.image = filteredImage
            }
            isFiltered = true
        }
    }
    

}


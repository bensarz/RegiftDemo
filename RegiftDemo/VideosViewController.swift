//
//  VideosViewController.swift
//  RegiftDemo
//
//  Created by Benoit Sarrazin on 2015-07-17.
//  Copyright (c) 2015 WorkshopX Inc. All rights reserved.
//

import UIKit
import Photos
import Regift
import SDWebImage

class VideosViewController: UIViewController {
    
    var assets: PHFetchResult?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension VideosViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! UICollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets?.count ?? 0
    }
    
}

extension VideosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
}

extension VideosViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = assets?[indexPath.item] as! PHAsset
        let video = PHImageManager.defaultManager().requestAVAssetForVideo(asset, options: nil) { (avasset, audiomix, info) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let a = avasset as! AVURLAsset
                let durationInSeconds = CMTimeGetSeconds(a.duration)
                let framesPerSecond = a.tracks[0].nominalFrameRate
                let numberOfFrames = Int(durationInSeconds) * Int(framesPerSecond)
                let imageURL = Regift.createGIFFromURL(a.URL, withFrameCount: numberOfFrames / 4, delayTime: 0)
                let data = NSData(contentsOfURL: imageURL!)
                let image = UIImage.sd_animatedGIFWithData(data)
                if let imageView = self.imageView {
                    self.imageView.removeFromSuperview()
                }
                self.imageView = UIImageView(frame: self.view.bounds)
                self.view.addSubview(self.imageView)
                self.imageView.image = image!
            })
        }
    }
    
}

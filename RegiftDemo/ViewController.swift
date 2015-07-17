//
//  ViewController.swift
//  RegiftDemo
//
//  Created by Benoit Sarrazin on 2015-07-17.
//  Copyright (c) 2015 WorkshopX Inc. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    let videoAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: .SmartAlbumVideos, options: nil)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! VideosViewController
        dest.assets = PHAsset.fetchAssetsInAssetCollection(videoAlbums[0] as! PHAssetCollection, options: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! UITableViewCell
        let collection = videoAlbums[indexPath.row] as! PHCollection
        cell.textLabel?.text = collection.localizedTitle
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoAlbums.count
    }
    
}


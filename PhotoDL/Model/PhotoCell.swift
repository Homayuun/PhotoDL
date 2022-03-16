//
//  PhotoCell.swift
//  photolode
//
//  Created by Homayun on 12/9/1400 AP.
//  Copyright © 1400 AP Homayun. All rights reserved.
//


import UIKit

var imageCache: NSCache<AnyObject, AnyObject> = NSCache()

class PhotoCell: UITableViewCell {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    func downloadImage(withUrlString urlString: String) {
        let url = URL(string: urlString)!
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.photoImageView.image = imageFromCache
            return
        }
        let queue = DispatchQueue(label: "concurrent Queue", qos: .default, attributes: .concurrent)
        DispatchQueue.global(qos: .default).async {
            
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                debugPrint(String(describing: error?.localizedDescription))
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                self.photoImageView.image = imageToCache
                self.spinner.stopAnimating()
                imageCache.setObject(imageToCache!, forKey: url.absoluteString as AnyObject)
            }
        }).resume()
        }
    }
}

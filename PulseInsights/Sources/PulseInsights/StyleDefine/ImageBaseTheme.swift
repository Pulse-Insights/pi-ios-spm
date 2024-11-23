//
//  ImageBaseTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

open class ImageBaseTheme {
    var width = 0
    var height = 0
    var margin = 0
    var horizonAlign = "center"

    func applyNewStyle(newStyle: ImageBaseTheme) {
        self.width = newStyle.width
        self.height = newStyle.height
        self.margin = newStyle.margin
        self.horizonAlign = newStyle.horizonAlign
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    func configHorizontalAlign(_ imageView:UIImageView!) {
        if horizonAlign.compare("right", options: .caseInsensitive) == .orderedSame {
            imageView!.trailingAnchor.constraint(equalTo: imageView!.superview!.trailingAnchor).isActive = true
        } else if horizonAlign.compare("left", options: .caseInsensitive) == .orderedSame {
            imageView!.leadingAnchor.constraint(equalTo: imageView!.superview!.leadingAnchor).isActive = true
        } else {
            imageView!.centerXAnchor.constraint(equalTo: imageView!.superview!.centerXAnchor).isActive = true
        }
    }

    func downloadImage(url: URL, imageView:UIImageView!, containerView:UIView!, heighConstrain:NSLayoutConstraint? = nil, widthConstrain:NSLayoutConstraint? = nil) {
        print("Download Started/URL = \(url)")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                let margin = CGFloat(self.margin)
                imageView.image = UIImage(data: data)?.imageWithInsets(insetDimen: margin)
                imageView.contentMode = .scaleAspectFit
                imageView.backgroundColor = UIColor.clear
                var imageHeight: CGFloat = 0.0
                var imageWidth: CGFloat = 0.0
                if(imageView.image?.size.height != nil) {
                    imageHeight = imageView.image?.size.height ?? 0
                }
                if(imageView.image?.size.width != nil) {
                    imageWidth = imageView.image?.size.width ?? 0
                }
                widthConstrain?.constant = imageWidth
                heighConstrain?.constant = imageHeight
                if containerView.frame.size.width < imageWidth {
                    heighConstrain?.constant =
                        containerView.frame.size.width * imageHeight / imageWidth
                }
                if self.width > 0 {
                    widthConstrain?.constant = CGFloat(self.width)
                }
                if self.height > 0 {
                    heighConstrain?.constant = CGFloat(self.height)
                }
            }
        }
    }
}

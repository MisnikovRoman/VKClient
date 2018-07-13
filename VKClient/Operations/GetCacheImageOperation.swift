//
//  GetCacheImage.swift
//  filemanager
//
//  Created by Роман Мисников on 08.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class GetCacheImageOperation: Operation {
    
    override var name: String? { get { return "GetCacheImage" } set { } }
    
    // life time of cache
    private let cacheLifeTime: TimeInterval = 3600
    
    // STATIC get path to "images" folder (and create it if needed)
    private static let pathName: String = {
        // name of folder
        let pathName = "images"
        // url to caches directory
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        // url to images folder
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        // create images folder if it isn't existing
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    // initial url
    private let url: String
    
    // cached image
    var outputImage: UIImage?
    
    // path to file folder
    private lazy var filePath: String? = {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = String(describing: url.hashValue)
        
        return cachesDirectory.appendingPathComponent(GetCacheImageOperation.pathName + "/" + hashName).path
    }()

    // initialization
    init(url: String) { self.url = url }
    
    override func main() {
        
        // check file path
        guard filePath != nil && !isCancelled else { return }
        // try to get image from cache, if no image in cache - next step
        guard !getImageFromCache() else { return }
        // if operation was cancelled - break
        guard !isCancelled else { return }
        // download image from server
        guard downloadImage() else { return }
        // if operation was cancelled - break
        guard !isCancelled else { return }
        // save downloaded image
        saveImageToCache()
    }
    
    // get from cache to output image
    private func getImageFromCache() -> Bool {
        // get date of modification
        guard let fileName = filePath,
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return false }
        // calculate life time
        let lifeTime = Date().timeIntervalSince(modificationDate)
        // compare life times
        guard lifeTime < cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
            else { return false }
        // if life time doesn't come out - save to output image
        self.outputImage = image
        // return success flag
        return true
    }
    
    // download from url to output image
    private func downloadImage() -> Bool {
        guard let url = URL(string: url),
            let data = try? Data.init(contentsOf: url),
            let image = UIImage(data: data)
            else { return false }
        self.outputImage = image
        return true
    }
    
    // save downloaded image
    private func saveImageToCache() {
        guard let fileName = filePath,
            let image = outputImage,
            let data = UIImagePNGRepresentation(image)
            else { return }
        print("🎈", fileName)
        
        let dict: [String: String] = ["fileName": fileName ]
        let message = Notification(name: .init("NewCacheFileWasCreated"), object: nil, userInfo: dict)
        NotificationCenter.default.post(message)
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

}






















//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import SwiftUI

class LocalFileManager {
    static let shard = LocalFileManager()
    private init() { }

    private func createURLIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path,
                    withIntermediateDirectories: true,
                    attributes: nil)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }


    // save
    func saveImage(_ image: UIImage, imageName: String, folderName: String) {
        // create the folder if needed
        createURLIfNeeded(folderName: folderName)

        // guard path to image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }

        // then save the image
        do {
            try data.write(to: url)
            print("Image Saved")
        } catch let error {
            print(error.localizedDescription)
        }

    }

    // get
    func getImage(imageName: String, folderName: String) -> UIImage? {
        // guard url and file exists
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }

        // if image found return it
        if let image = UIImage(contentsOfFile: url.path) {
            print("image found")
            return image
        }
        
        // no image found return nil
        return nil
    }

    private func getURLForFolder(_ folder: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folder)
    }

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        return getURLForFolder(folderName)?.appendingPathComponent(imageName + ".png")
    }
}

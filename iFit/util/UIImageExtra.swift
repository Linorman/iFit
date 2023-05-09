//
//  UIImageExtra.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/9.
//

import Foundation
import SwiftUI

extension UIImage {
    func saveToDisk() -> URL? {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            let fileName = UUID().uuidString + ".png"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                try self.pngData()?.write(to: fileURL)
                return fileURL
            } catch {
                return nil
            }
        }
}

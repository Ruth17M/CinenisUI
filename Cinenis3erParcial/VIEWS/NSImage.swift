	//
//  NSImage.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//

import AppKit

extension NSImage {
    func averageLuminance() -> CGFloat {
        guard let tiffData = self.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiffData) else { return 1.0 }

        let width = bitmap.pixelsWide
        let height = bitmap.pixelsHigh

        var totalLuminance: CGFloat = 0
        var count = 0

        for x in stride(from: 0, to: width, by: 10) {
            for y in stride(from: 0, to: height, by: 10) {
                guard let color = bitmap.colorAt(x: x, y: y) else { continue }
                let luminance = 0.299 * color.redComponent + 0.587 * color.greenComponent + 0.114 * color.blueComponent
                totalLuminance += luminance
                count += 1
            }
        }

        return count > 0 ? totalLuminance / CGFloat(count) : 1.0
    }
}

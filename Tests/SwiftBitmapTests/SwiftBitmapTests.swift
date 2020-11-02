import XCTest
@testable import SwiftBitmap

final class SwiftBitmapTests: XCTestCase {
    
    func testFileSave() {
        let bm = SBBitmap(128,128)
        if let data = bm.gif() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/test.gif"))
        }
        if let data = bm.png() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/test.png"))
        }
        if let data = bm.jpg() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/test.jpg"))
        }
        if let data = bm.tga() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/test.tga"))
        }
        if let data = bm.pcx() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/test.pcx"))
        }
    }
    
    func testGeometry() {
        // ARGB
        let red: UInt32 = 0xFFFF0000
        let green: UInt32 = 0xFF00FF00
        let blue: UInt32 = 0xFF0000FF
        let white: UInt32 = 0xFFFFFFFF
        
        let r = SBRect(0, 0, 128, 128)
        let bm = SBBitmap(r.w, r.h)
        bm.set(color: red)
        bm.fill(circle: r)
        bm.set(color: green)
        bm.stroke(circle: r)
        
        let r2 = r.inset(32)
        bm.set(color: blue)
        bm.fill(roundrect: r2, radius: 8)
        
        let a = r.interp(0.0, 0.0)
        let b = r.interp(1.0, 0.0)
        let c = r.interp(1.0, 1.0)
        let d = r.interp(0.0, 1.0)
        
        bm.set(color: white)
        bm.line(from: a, to: c)
        bm.line(from: b, to: d)
        
        if let data = bm.gif() {
            try? data.write(to: URL(fileURLWithPath: "/tmp/geometry.gif"))
        }
    }

    static var allTests = [
        ("testFileSave", testFileSave),
        ("testGeometry", testGeometry),
    ]
}

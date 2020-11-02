import bitmap
import Foundation

private func lerp(_ a: Int32, _ b: Int32, _ f: Float) -> Int32 {
    return a + Int32(Float(b - a) * f)
}

public struct SBPoint {
    var x: Int32
    var y: Int32
    
    public init(_ _x: Int32, _ _y: Int32) {
        x = _x
        y = _y
    }
}

public struct SBRect {
    var x: Int32
    var y: Int32
    var w: Int32
    var h: Int32
    
    public init(_ _x: Int32, _ _y: Int32, _ _w: Int32, _ _h: Int32) {
        x = _x
        y = _y
        w = _w
        h = _h
    }
    
    public func interp(_ ix: Float, _ iy: Float) -> SBPoint {
        return SBPoint(lerp(x, x + w, ix), lerp(y, y + h, iy))
    }
    
    public func inset(_ v: Int32) -> SBRect {
        return SBRect(
            x + v,
            y + v,
            w - v * 2,
            h - v * 2
        )
    }
    
    public func inset(_ vX: Int32, _ vY: Int32) -> SBRect {
        return SBRect(
            x + vX,
            y + vY,
            w - vX * 2,
            h - vY * 2
        )
    }
    
    public func inset(_ top: Int32, _ left: Int32, _ bottom: Int32, _ right: Int32) -> SBRect {
        return SBRect(
            x + left,
            y + top,
            w - left + right,
            h - top + bottom
        )
    }
}

import bitmap
import Foundation

public enum SBScaling {
    case nearest
    case bilinear
    case bicubic
}

public class Bitmap {
    
    var bm: OpaquePointer?
    
    public init(_ width: Int32, _ height: Int32) {
        bm = bm_create(width, height)
    }
    
    deinit {
        if bm != nil {
            bm_free(bm);
        }
    }
    
    public init(image: Data) {
        image.withUnsafeBytes {
            bm = bm_load_mem($0.baseAddress, $0.count)
        }
    }
    
    public init(path: String) {
        bm = bm_load(path)
    }
    
    
    
    private func convert(_ name: String) -> Data? {
        var bytes: UnsafeMutablePointer<Int8>? = nil
        var size: Int = 0
        if bm_convert(bm, name, &bytes, &size) != 0 {
            return Data(bytesNoCopy: bytes!, count: size, deallocator: .free)
        }
        return nil
    }
    
    public func png() -> Data? {
        return convert("temp.png")
    }
    
    public func pcx() -> Data? {
        return convert("temp.pcx")
    }
    
    public func gif() -> Data? {
        return convert("temp.gif")
    }
    
    public func tga() -> Data? {
        return convert("temp.tga")
    }
    
    public func jpg() -> Data? {
        return convert("temp.jpg")
    }
    
    public func set(color: UInt32) {
        bm_set_color(bm, color)
    }
    
    public func line(from: SBPoint, to: SBPoint) {
        bm_line_aa(bm, from.x, from.y, to.x, to.y)
    }
    
    public func stroke(rect: SBRect) {
        bm_rect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    public func fill(rect: SBRect) {
        bm_fillrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    public func stroke(circle rect: SBRect) {
        bm_ellipse(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    public func fill(circle rect: SBRect) {
        bm_fillellipse(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    public func stroke(roundrect rect: SBRect, radius: Int32) {
        bm_roundrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h, radius)
    }
    
    public func fill(roundrect rect: SBRect, radius: Int32) {
        bm_fillroundrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h, radius)
    }
    
    public func flip() {
        bm_flip_vertical(bm)
    }
    
    public func copy(_ dx: Int32, _ dy: Int32, _ other: Bitmap, _ src: SBRect) {
        bm_blit(bm, dx, dy, other.bm, src.x, src.y, src.w, src.h)
    }
    
    public func draw(_ dst: SBRect, _ other: Bitmap, _ src: SBRect) {
        bm_blit_ex(bm, dst.x, dst.y, dst.w, dst.h, other.bm, src.x, src.y, src.w, src.h, 0)
    }
    
    public func grayscale() {
        bm_grayscale(bm)
    }
    
    public func blur() {
        bm_smooth(bm)
    }
    
    public func resize(_ nw: Int32, _ nh: Int32, _ method: SBScaling = .bilinear) {
        let old = bm
        switch method {
        case .nearest:
            bm = bm_resample(bm, nw, nh)
        case .bilinear:
            bm = bm_resample(bm, nw, nh)
        case .bicubic:
            bm = bm_resample(bm, nw, nh)
        }
        bm_free(old)
    }
    
}

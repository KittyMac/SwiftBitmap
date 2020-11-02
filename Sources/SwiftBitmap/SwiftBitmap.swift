import bitmap
import Foundation

enum SBScaling {
    case nearest
    case bilinear
    case bicubic
}

class Bitmap {
    
    var bm: OpaquePointer?
    
    init(_ width: Int32, _ height: Int32) {
        bm = bm_create(width, height)
    }
    
    deinit {
        if bm != nil {
            bm_free(bm);
        }
    }
    
    init(image: Data) {
        image.withUnsafeBytes {
            bm = bm_load_mem($0.baseAddress, $0.count)
        }
    }
    
    init(path: String) {
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
    
    func png() -> Data? {
        return convert("temp.png")
    }
    
    func pcx() -> Data? {
        return convert("temp.pcx")
    }
    
    func gif() -> Data? {
        return convert("temp.gif")
    }
    
    func tga() -> Data? {
        return convert("temp.tga")
    }
    
    func jpg() -> Data? {
        return convert("temp.jpg")
    }
    
    func set(color: UInt32) {
        bm_set_color(bm, color)
    }
    
    func line(from: SBPoint, to: SBPoint) {
        bm_line_aa(bm, from.x, from.y, to.x, to.y)
    }
    
    func stroke(rect: SBRect) {
        bm_rect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    func fill(rect: SBRect) {
        bm_fillrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    func stroke(circle rect: SBRect) {
        bm_ellipse(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    func fill(circle rect: SBRect) {
        bm_fillellipse(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h)
    }
    
    func stroke(roundrect rect: SBRect, radius: Int32) {
        bm_roundrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h, radius)
    }
    
    func fill(roundrect rect: SBRect, radius: Int32) {
        bm_fillroundrect(bm, rect.x, rect.y, rect.x + rect.w, rect.y + rect.h, radius)
    }
    
    func flip() {
        bm_flip_vertical(bm)
    }
    
    func copy(_ dx: Int32, _ dy: Int32, _ other: Bitmap, _ src: SBRect) {
        bm_blit(bm, dx, dy, other.bm, src.x, src.y, src.w, src.h)
    }
    
    func draw(_ dst: SBRect, _ other: Bitmap, _ src: SBRect) {
        bm_blit_ex(bm, dst.x, dst.y, dst.w, dst.h, other.bm, src.x, src.y, src.w, src.h, 0)
    }
    
    func grayscale() {
        bm_grayscale(bm)
    }
    
    func blur() {
        bm_smooth(bm)
    }
    
    func resize(_ nw: Int32, _ nh: Int32, _ method: SBScaling = .bilinear) {
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

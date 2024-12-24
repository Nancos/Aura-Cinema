import Kingfisher
import UIKit
import Foundation

protocol SettingsPresnterProtocol {
    func exit()
    func didUpdateCacheSize(_ size: String)
}

final class SettingsPresnter {
    private let authService = AuthService.shared
    private let cache = ImageCache.default
    var delegate: SettingsPresnterProtocol?
    
    func exit() {
        authService.signOut()
        delegate?.exit()
    }
    
    @MainActor
    func updateCacheSize() async {
        let cacheSize = (try? await cache.diskStorageSize) ?? 0
        let formattedCache = ByteCountFormatter.string(fromByteCount: Int64(cacheSize), countStyle: .file)
        delegate?.didUpdateCacheSize(formattedCache)
    }
    
    func clearCache() async {
        await cache.clearDiskCache()
        await updateCacheSize()
    }
}

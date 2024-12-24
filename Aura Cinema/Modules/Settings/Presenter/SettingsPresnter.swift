//
//  SettingsPresnter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 24.01.25.
//
import Kingfisher
import Foundation

protocol SettingsPresnterProtocol {
    func exit()
    func didUpdateCacheSize(_ size: String)
}

class SettingsPresnter {
    private let authService = AuthService()
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

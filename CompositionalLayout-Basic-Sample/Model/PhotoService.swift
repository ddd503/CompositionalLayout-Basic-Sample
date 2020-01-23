//
//  PhotoService.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/23.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import Photos

final class PhotoService {

    static func canAccess() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized
    }

    static func needsToRequestAccess() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .notDetermined
    }

    static func requestAuthorizationIfNeeded(completion handler: @escaping (Bool) -> Void) {
        guard PhotoService.needsToRequestAccess() else {
            handler(PhotoService.canAccess())
            return
        }
        PHPhotoLibrary.requestAuthorization { _ in
            handler(PhotoService.canAccess())
        }
    }

    static func photoList() -> PHFetchResult<PHAsset> {
        let assets = PHAsset.fetchAssets(with: nil)
        return assets
    }
}

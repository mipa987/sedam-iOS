//
//  ImageSaver.swift
//  Sedam
//
//  Created by minsong kim on 5/30/25.
//

import UIKit

// UIImage를 포토 라이브러리에 저장하고, 완료를 콜백으로 알려줍니다.
final class ImageSaver: NSObject {
    private var onComplete: ((Result<Void, Error>) -> Void)?

    // 저장 시작
    func writeToPhotoLibrary(_ image: UIImage,
                             completion: ((Result<Void, Error>) -> Void)? = nil) {
        self.onComplete = completion
        UIImageWriteToSavedPhotosAlbum(
            image,
            self,
            #selector(saveCompleted(_:didFinishSavingWithError:contextInfo:)),
            nil
        )
    }

    // 저장 완료 핸들러
    @objc private func saveCompleted(_ image: UIImage,
                                     didFinishSavingWithError error: Error?,
                                     contextInfo: UnsafeRawPointer) {
        if let error = error {
            onComplete?(.failure(error))
        } else {
            onComplete?(.success(()))
        }
    }
}

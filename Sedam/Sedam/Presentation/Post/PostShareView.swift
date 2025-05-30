//
//  PostShareView.swift
//  Sedam
//
//  Created by minsong kim on 5/29/25.
//

import SwiftUI

struct PostShareView: View {
    var title: String
    var content: String
    var words: String
    @State var isThreeWords: Bool = false
    @State var backgroundColor: Color = .modernIvory
    @State var fontColors: Color = .black
    @State private var showImageSavePopup: Bool = false
    @State private var imageSavePopUpMessage: String = ""
    @State private var imageSaver = ImageSaver()
    
    var body: some View {
        VStack {
            Spacer()
            Text("템플릿일 뿐, 실제 이미지에서는 여백이 다를 수 있습니다.")
                .font(.pretendardSemiBold14)
            CardView(
                title: title,
                content: content,
                words: words,
                colors: $backgroundColor,
                fontColors: $fontColors,
                isThreeWords: $isThreeWords
            )
            .roundedCorner(16, corners: .allCorners)
            .padding(12)
            Toggle("3단어 표시", isOn: $isThreeWords)
                .padding(.horizontal, 120)
                .font(.pretendardSemiBold14)
                .toggleStyle(.switch)
            HStack {
                Rectangle()
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    .foregroundStyle(.modernIvory)
                    .onTapGesture {
                        backgroundColor = .modernIvory
                        fontColors = .black
                    }
                Rectangle()
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    .foregroundStyle(.tranquility)
                    .onTapGesture {
                        backgroundColor = .tranquility
                        fontColors = .black
                    }
                Rectangle()
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    .foregroundStyle(.juniperBerries)
                    .onTapGesture {
                        backgroundColor = .juniperBerries
                        fontColors = .white
                    }
                Rectangle()
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    .foregroundStyle(.dadsCoupe)
                    .onTapGesture {
                        backgroundColor = .dadsCoupe
                        fontColors = .white
                    }
            }
            Spacer()
            MainButton(title: "텍스트만 공유하기", font: .pretendardSemiBold14, color: .juniperBerries)
                .tap {
                    let shareText = [title, content]
                        .joined(separator: "\n\n")
                    let activityVC = UIActivityViewController(
                        activityItems: [shareText],
                        applicationActivities: nil
                    )
                    if let root = UIApplication.shared.windows.first?.rootViewController {
                        root.present(activityVC, animated: true)
                    }
                }
                .padding(.horizontal, 16)
            MainButton(title: "이미지 저장하기", font: .pretendardSemiBold14, color: .dadsCoupe)
                .tap {
                    let image = CardView (
                        title: title,
                        content: content,
                        words: words,
                        colors: $backgroundColor,
                        fontColors: $fontColors,
                        isThreeWords: $isThreeWords
                    ).renderedImage(withPadding: 50, backgroundColor: backgroundColor)
                    
                    imageSaver.writeToPhotoLibrary(image) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success:
                                imageSavePopUpMessage = "이미지 저장에 성공하였습니다!"
                            case .failure(_):
                                imageSavePopUpMessage = "이미지 저장에 실패했습니다.\n\n다시 시도해주세요."
                            }
                            withAnimation {
                                showImageSavePopup = true
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            
        }
        .overlay {
            if showImageSavePopup {
                SinglePopUpView(
                    showPopUp: $showImageSavePopup,
                    title: "이미지 저장",
                    message: imageSavePopUpMessage,
                    buttonText: "확인",
                    buttonAction: {
                        withAnimation {
                            showImageSavePopup = false
                        }
                    }
                )
            }
        }
    }
}

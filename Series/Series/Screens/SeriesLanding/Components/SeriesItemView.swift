//
//  SeriesItemView.swift
//  Series
//
//  Created by thanos kottaridis on 22/7/23.
//

import SwiftUI
import Domain
import Presentation

struct SeriesItemView: View {
    // MARK: - Constraint Constants
    private enum ConstraintConstants {
        static let largelCornerRadius = 24.adapted()
        static let normalCornerRadius = 16.adapted()
        
        static func getCellCornerRadius(isLarge: Bool) -> CGFloat {
            return isLarge ? largelCornerRadius : normalCornerRadius
        }
    }
    
    // MARK: - DI
    @Injected(\.photosManager)
    private var photosManager: PhotosManager
    
    // MARK: - VARS
    @State private var image: UIImage? = UIImage()
    var show: Show
    var isLargeCell: Bool
    
    var body: some View {
        
        ZStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(image == nil ? ColorPalette.FillPrimary.value.swiftUIColor : .clear)
                .clipShape(RoundedRectangle(cornerRadius: ConstraintConstants.getCellCornerRadius(isLarge: isLargeCell)))
            
            if image == nil {
                Text(show.title ?? "")
                    .modifier(CustomTextStyle(style: .body1(weight: .BOLD)))
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            fetchBackgroundImage()
        }
    }
    
    private func fetchBackgroundImage() {
        
        guard let mediaId = show.posterPath else {
            self.image = nil
            return
        }
        
        Task.init {
            let result = await photosManager.fetchImage(mediaId: mediaId, size:.w300)
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let image):
                    self.image = image
                    
                case .Failure(_):
                    self.image = nil
                    break
                }
            }
        }
    }
}

struct SeriesItemView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesItemView(
            show: Show(),
            isLargeCell: true
        )
    }
}

//
//  FilmPoster.swift
//  FilmHub
//
//  Created by Zakhar Litvinchuk on 21.05.2024.
//

import SwiftUI

struct FilmPosterView: UIViewRepresentable {
    private let posterLink: URL
    
    init(posterLink: URL) {
        self.posterLink = posterLink
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIImageView()
        view.sd_setImage(with: posterLink)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

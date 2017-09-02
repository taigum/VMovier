//
//  BMPlayerCustomControlView.swift
//  VMovie
//
//  Created by vara shen on 2017/8/31.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import BMPlayer
import NVActivityIndicatorView
class BMPlayerCustomControlView: BMPlayerControlView {
    
    var playShareButton = UIButton(type: .custom)
    var playRate: Float = 1.0
    
    var downloadButton = UIButton(type: .custom)

    
    /**
     Override if need to customize UI components
     */
    override func customizeUIComponents() {
        mainMaskView.backgroundColor   = UIColor.clear
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballSpinFadeLoader
        topMaskView.backgroundColor    = UIColor.black.withAlphaComponent(0)
        bottomMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        timeSlider.setThumbImage(UIImage(named: "custom_slider_thumb"), for: .normal)
        
        topMaskView.addSubview(playShareButton)
        playShareButton.setImage(UIImage(named:"share"), for: .normal)
        playShareButton.addTarget(self, action: #selector(onShareMovieButtonPressed), for: .touchUpInside)
        playShareButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        playShareButton.isHidden = true

        playShareButton.snp.makeConstraints {
            $0.right.equalTo(topMaskView.snp.right).offset(-150)
            $0.centerY.equalTo(titleLabel.snp.top).offset(5)
        }
        
        topMaskView.addSubview(downloadButton)
        downloadButton.setImage(UIImage(named: "download"), for: .normal)
        downloadButton.addTarget(self, action: #selector(onRotateButtonPressed), for: .touchUpInside)
        downloadButton.isHidden = true
        downloadButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        downloadButton.snp.makeConstraints {
            $0.right.equalTo(topMaskView.snp.right).offset(-100)
            $0.centerY.equalTo(titleLabel.snp.top).offset(5)
        }
    }
    
    override func updateUI(_ isForFullScreen: Bool) {
        super.updateUI(isForFullScreen)
        playShareButton.isHidden = !isForFullScreen
        downloadButton.isHidden = !isForFullScreen
        if let layer = player?.playerLayer {
            layer.frame = player!.bounds
        }
    }
    
    func onShareMovieButtonPressed() {
        print("share")
    }
    
    func onRotateButtonPressed() {
        print("download")
    }
}

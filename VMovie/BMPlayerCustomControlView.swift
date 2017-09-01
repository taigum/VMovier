//
//  BMPlayerCustomControlView.swift
//  VMovie
//
//  Created by vara shen on 2017/8/31.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import BMPlayer

class BMPlayerCustomControlView: BMPlayerControlView {
    
    var playbackRateButton = UIButton(type: .custom)
    var playRate: Float = 1.0
    
    var rotateButton = UIButton(type: .custom)
    var rotateCount: CGFloat = 0
    
    /**
     Override if need to customize UI components
     */
    override func customizeUIComponents() {
        mainMaskView.backgroundColor   = UIColor.clear
        topMaskView.backgroundColor    = UIColor.black.withAlphaComponent(0.4)
        bottomMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        timeSlider.setThumbImage(UIImage(named: "custom_slider_thumb"), for: .normal)
        
        topMaskView.addSubview(playbackRateButton)
        playbackRateButton.setImage(UIImage(named:"share"), for: .normal)
        playbackRateButton.addTarget(self, action: #selector(onShareMovieButtonPressed), for: .touchUpInside)
        playbackRateButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        playbackRateButton.isHidden = true

        playbackRateButton.snp.makeConstraints {
            $0.right.equalTo(topMaskView.snp.right).offset(-150)
            $0.centerY.equalTo(titleLabel.snp.top).offset(5)
        }
        
        topMaskView.addSubview(rotateButton)
        rotateButton.setImage(UIImage(named: "download"), for: .normal)
        rotateButton.addTarget(self, action: #selector(onRotateButtonPressed), for: .touchUpInside)
        rotateButton.isHidden = true
        rotateButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rotateButton.snp.makeConstraints {
            $0.right.equalTo(topMaskView.snp.right).offset(-100)
            $0.centerY.equalTo(titleLabel.snp.top).offset(5)
        }
    }
    
    override func updateUI(_ isForFullScreen: Bool) {
        super.updateUI(isForFullScreen)
        playbackRateButton.isHidden = !isForFullScreen
        rotateButton.isHidden = !isForFullScreen
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

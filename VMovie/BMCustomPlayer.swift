//
//  BMCustomPlayer.swift
//  VMovie
//
//  Created by vara shen on 2017/8/31.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import BMPlayer

class BMCustomPlayer: BMPlayer {
    class override func storyBoardCustomControl() -> BMPlayerControlView? {
        return BMPlayerCustomControlView()
    }
}

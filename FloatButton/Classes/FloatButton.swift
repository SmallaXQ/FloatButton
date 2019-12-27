//
//  FloatButton.swift
//  SASpecs
//
//  Created by Smalla on 2019/11/15.
//  Copyright © 2019 SASpecs. All rights reserved.
//

import UIKit

// 悬浮按钮
public class FloatButton: UIButton {
    
    // 是否可拖拽
    var isDragEnable: Bool = true
    
    // 拖拽后是否自动移到边缘
    var isAbsortEnable: Bool = true
    
    // 正常情况下 透明度
    var alphaOfNormol: CGFloat = 0.4
    
    // 拖拽时的透明度
    var alphaOfDrag: CGFloat = 1.0
    
    // 拖拽结束后的等待时间
    var timeOfWait: CGFloat = 1
    
    // 拖拽结束后的过渡动画时间
    var timeOfAnimation: CGFloat = 0.3
    
    // 按钮距离边缘的内边距
    var paddingOfbutton: CGFloat = 2
    
    // 计时器
    fileprivate var timer: Timer? = nil
    
    // 内部使用 起到数据传递的作用
    fileprivate var allPoint: CGPoint? = nil
    
    // 内部使用
    fileprivate var isHasMove: Bool = false
    
    // 拖拽取消点击事件
    fileprivate var isFirstClick: Bool = true
    
    // 点击回调
    var singleClickCallback: (()->())? = nil
    
    convenience init(_ alphaOfNormol: CGFloat = 0.4,
                     bgColor: UIColor? = UIColor.red,
                     radiuOfButton: CGFloat = 12,
                     titleOfButton: String = "",
                     titleColorOfButton: UIColor? = UIColor.white) {
        self.init()
        
        alpha = alphaOfNormol
        backgroundColor = bgColor
        layer.cornerRadius = radiuOfButton
        setTitle(titleOfButton, for: .normal)
        
        self.alphaOfNormol = alphaOfNormol
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = self.alphaOfDrag
        // 计时器取消
        self.timer?.invalidate()
        // 不可拖拽则退出执行
        if !isDragEnable {
            return
        }
        self.allPoint = touches.first?.location(in: self)
        if touches.first?.tapCount == 1  {
            self.perform(#selector(singleClick), with: nil, afterDelay: 0.2)
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHasMove = true
        if self.isFirstClick {
            // 拖拽滑动过程中取消单次点击事件
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(singleClick), object: nil)
            self.isFirstClick = false
        }
        if !isDragEnable {
            return
        }
        let temp = touches.first?.location(in: self)
        // 计算偏移量
        let offsetx = (temp?.x)! - (self.allPoint?.x)!
        let offsety = (temp?.y)! - (self.allPoint?.y)!
        self.center = CGPoint.init(x: self.center.x + offsetx, y: self.center.y + offsety)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isFirstClick = true
        if #available(iOS 10.0, *) {
            self.timer = Timer.init(timeInterval: TimeInterval(self.timeOfWait), repeats: false, block: { (Timer) in
                // 过渡
                UIView.animate(withDuration: TimeInterval(self.timeOfAnimation), animations: {
                    self.alpha = self.alphaOfNormol
                })
            })
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeOfWait), target: self, selector: #selector(timeAction), userInfo: nil, repeats: false)
        }
        
        // 这段代码只有在按钮移动后才需要执行
        if self.isHasMove && isAbsortEnable && self.superview != nil {
            // 移到父view边缘
            let marginL = self.frame.origin.x
            let marginT = self.frame.origin.y
            let superFrame = self.superview?.frame
            let tempy = (superFrame?.height)! - 2 * self.frame.height - self.paddingOfbutton
            let tempx = (superFrame?.width)! - self.frame.width - self.paddingOfbutton
            let xOfR = (superFrame?.width)! - self.frame.width - self.paddingOfbutton
            UIView.animate(withDuration: 0.2, animations: {
                var x = self.frame.origin.x
                if marginT < self.frame.height + self.paddingOfbutton {
                    // 靠顶部
                    if x > tempx {
                        x = tempx
                    }
                    if x < self.paddingOfbutton {
                        x = self.paddingOfbutton
                    }
                    self.frame = CGRect.init(x: x, y: self.paddingOfbutton, width: self.frame.width, height: self.frame.height)
                } else if marginT > tempy {
                    // 靠底部
                    if x > tempx {
                        x = tempx
                    }
                    if x < self.paddingOfbutton {
                        x = self.paddingOfbutton
                    }
                    let y = tempy + self.frame.height
                    self.frame = CGRect.init(x: x, y: y, width: self.frame.width, height: self.frame.height)
                } else if marginL > ((superFrame?.width)! / 2 - self.frame.width / 2) {
                    // 靠右移动
                    self.frame = CGRect.init(x: xOfR, y: marginT, width: self.frame.width, height: self.frame.height)
                } else {
                    // 靠左移动
                    self.frame = CGRect.init(x: self.paddingOfbutton, y: marginT, width: self.frame.width, height: self.frame.height)
                }
            })
        }
        self.isHasMove = false
        // 将计时器加入runloop
        if let temptime = self.timer {
            RunLoop.current.add(temptime, forMode: .common)
        }
    }
    
    @objc func singleClick() {
        singleClickCallback?()
    }
    
    @objc func timeAction() {
        UIView.animate(withDuration: TimeInterval(self.timeOfAnimation), animations: {
            self.alpha = self.alphaOfNormol
        })
    }
}

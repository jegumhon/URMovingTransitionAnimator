//
//  URTransitionReceivable.swift
//  URMovingTransitionAnimator
//
//  Created by jegumhon on 2017. 2. 14..
//  Copyright © 2017년 chbreeze. All rights reserved.
//

import Foundation

@objc public protocol URTransitionReceivable {
    var transitionView: UIView? { get set }

    func transitionFinishingFrame(startingFrame: CGRect) -> CGRect
    func makeTransitionView(originView: UIView)
    func removeTransitionView()
}

public extension URTransitionReceivable where Self: UIViewController {
    func makeTransitionView(originView: UIView) {
        if let view = self.transitionView {
            self.view.bringSubview(toFront: view)
        } else {
            self.view.addSubview(originView)

            self.transitionView = originView
        }
    }

    func removeTransitionView() {
        if let view = self.transitionView {
            UIView.animate(withDuration: 1.5, animations: {
                view.alpha = 0.1
            }, completion: { (finish) in
                self.view.sendSubview(toBack: view)
            })
        }
    }
}

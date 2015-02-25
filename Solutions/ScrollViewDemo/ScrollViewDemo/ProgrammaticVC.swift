//
//  ProgrammaticVC.swift
//  ScrollViewDemo
//
//  Created by trvslhlt on 2/23/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ProgrammaticVC: UIViewController {
  
  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: CGRect(origin: CGPointZero, size: UIScreen.mainScreen().bounds.size))
    sv.backgroundColor = UIColor.blueColor()
    sv.contentSize = CGSize(width: 1000, height: 2000)
    return sv
    }()
  lazy var littleView: UIView = {
    let v = UIView(frame: CGRect(origin: CGPoint(x: 500, y: 1000), size: CGSize(width: 200, height: 200)))
    v.backgroundColor = UIColor.redColor()
    return v
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(scrollView)
    self.scrollView.addSubview(littleView)
  }
  
}

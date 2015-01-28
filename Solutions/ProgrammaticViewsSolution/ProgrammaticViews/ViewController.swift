//
//  ViewController.swift
//  ProgrammaticViews
//
//  Created by trvslhlt on 1/7/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let widget: UIButton
  var widgetIsHome = true
  var topWidgetConstraint: NSLayoutConstraint?
  let widgetHomeSpacing: CGFloat = 20
  let widgetAwaySpacing: CGFloat = 200
  
  override init() {
    widget = UIButton()
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupWidget()
  }
  
  func setupWidget() {
    let width: CGFloat = 50
    let height = width
    self.view.addSubview(widget)
    widget.setTranslatesAutoresizingMaskIntoConstraints(false)
    let widthConstraint = NSLayoutConstraint(item: widget, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width)
    let heightConstraint = NSLayoutConstraint(item: widget, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: height)
    let leftConstraint = NSLayoutConstraint(item: widget, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 0.0)
    topWidgetConstraint = NSLayoutConstraint(item: widget, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: widgetHomeSpacing)
    
    if let twc = topWidgetConstraint {
      self.view.addConstraints([widthConstraint, heightConstraint, leftConstraint, twc])
    }
    
    widget.backgroundColor = UIColor.greenColor()
    widget.layer.cornerRadius = width / 10
    
    //prepare button to handle taps
    widget.addTarget(self, action: Selector("widgetTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
  }
  
  func widgetTapped(sender: UIButton) {
    animateWidget()
  }
  
  func animateWidget() {
    widgetIsHome = !widgetIsHome
    UIView.animateWithDuration(0.5, animations: {
      self.toggleWidgetColor()
      self.moveWidget()
    })
  }
  
  func toggleWidgetColor() {
    if widgetIsHome {
      widget.backgroundColor = UIColor.greenColor()
    } else {
      widget.backgroundColor = UIColor.whiteColor()
    }
  }
  
  func moveWidget() {
    if widgetIsHome {
      topWidgetConstraint?.constant = widgetHomeSpacing
    } else {
      topWidgetConstraint?.constant = widgetAwaySpacing
    }
    widget.layoutIfNeeded()
  }
  
  
  
}

// Playground - noun: a place where people can play

import UIKit

let view = UIView()
let buttons = ["AC", "±", "％", "÷", "7","8","9", "×", "4","5","6","−","1","2","3","+","0","."]

//for (button, i) in buttons {
//    let button = UIButton()
//    button.setTitle(buttons[button], forState: UIControlState.Normal)
//    button.backgroundColor = UIColor.grayColor()
//    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
//    button.titleLabel?.textColor = UIColor.whiteColor()
//    view.addSubview(button)
//}
var a = 7
let b = (0..<a).map{ Array(stride(from: $0, to: 10, by: 2)) }

print(a)
//  (0..<numberOfColumns).map { (0..<numberOfButtons).map { 4 * ($0 - 1) + 0 } }
var numberOfColumns = 4
var numberOfRows = 5
var c = (0..<numberOfColumns).map {
    (column) in (1...numberOfRows).map {
        (row) in numberOfColumns * (row - 1) + column
        }
    }

print(c)
var numberOfButtons = 20
var rows = (0..<numberOfRows).map {
    (row) in (0..<numberOfColumns).map {
        (column) in numberOfColumns * row + column
        }
    }

print(rows)

// intervals and pattern matching

//            // attach to all sides
//            switch index {
//            case 1...3, 5...6:


//            case row1:
//
//            case row2:
//
//            }
//            if row1 ~= index {
//                button.snp_makeConstraints { make in
//                    make.top.equalTo(self.displayLabel.snp_bottom)
//                    return
//                }

var w: ClosedInterval = 0...2
var y: ClosedInterval = 0...2
var i = 1
print(w)


switch i {
case w:
    print("1")
case y:
    print("2")
default:
    print("0")
}

_ = (0..<3).map { (a) in println(a) }

var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
var t = [red,green,blue].map { $0 - 0.1 }
t.0
t[0]


red




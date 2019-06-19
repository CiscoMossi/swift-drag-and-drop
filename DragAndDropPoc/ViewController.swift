//
//  ViewController.swift
//  DragAndDropPoc
//
//  Created by Francisco Mossi on 17/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

let draggedViewIncreasedSize: CGFloat = 20

class ViewController: UIViewController {

    @IBAction func addView(_ sender: UIButton) {
        let view = createView()
        
        let panGestureToCell = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        view.addGestureRecognizer(panGestureToCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addView(UIButton())
    }
    
    @objc func handlePan(recognizer:  UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        switch recognizer.state {
            case .began:
                setProportion(of: recognizerView, by: draggedViewIncreasedSize)
                applyShadow(to: recognizerView)
            case .ended:
                setProportion(of: recognizerView, by: -draggedViewIncreasedSize)
                removeShadow(from: recognizerView)
            default:
                break
        }
        
        let translation = recognizer.translation(in: view)
        recognizerView.center.x += translation.x
        recognizerView.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
    }
    
    func applyShadow(to view: UIView) {
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowOpacity = 1
    }
    
    func removeShadow(from view: UIView) {
        view.layer.shadowOpacity = 0
    }
    
    func setProportion(of view: UIView, by increaseValue: CGFloat) {
        let viewPosition = view.frame.origin
        view.frame = CGRect(x: viewPosition.x, y: viewPosition.y, width: view.frame.width + increaseValue, height: view.frame.height + increaseValue)
    }
    
    func createView() -> UIView {
        let dragAndDropView = UIView()
        
        dragAndDropView.translatesAutoresizingMaskIntoConstraints = false
        dragAndDropView.backgroundColor = .blue
        dragAndDropView.layer.shadowColor = UIColor.black.cgColor
        dragAndDropView.layer.shadowOffset = .zero
        dragAndDropView.layer.shadowRadius = 10
        dragAndDropView.layer.shouldRasterize = true
        dragAndDropView.layer.rasterizationScale = UIScreen.main.scale
        
        view.addSubview(dragAndDropView)
        
        view.addConstraint(NSLayoutConstraint(item: dragAndDropView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: dragAndDropView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
        view.addConstraint(NSLayoutConstraint(item: dragAndDropView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: dragAndDropView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50))
        
        return dragAndDropView
    }
}


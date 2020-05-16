//
//  ViewController.swift
//  Sesion05-01
//
//  Created by Kenyi Rodriguez on 5/16/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!

    
    @IBAction func clickBtnCreate(_ sender: Any) {
        
        let boxView = BoxView()
        boxView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        boxView.delegate = self
        self.contentView.addSubview(boxView)
        
        boxView.setRandomCenter()
        boxView.setRandomBackgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: BoxViewDelegate {
    
    func boxView(_ view: BoxView, didTapGesture tapGesture: UITapGestureRecognizer) {
        view.animateState()
    }
}




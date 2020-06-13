//
//  CSMTableView.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 8/05/18.
//

import UIKit

@objc public protocol CSMTableViewDelegate {
    @objc optional func tableView(_ tableView: UITableView, pullToRefresh refreshControl: UIRefreshControl?)
    @objc optional func tableView(_ tableView: UITableView, endLessScrollingWithOffset offset: CGPoint)
}

@IBDesignable public class CSMTableView: UITableView {

    fileprivate var observer : NSKeyValueObservation?
    
    @IBOutlet public var csmDelegate : CSMTableViewDelegate?
    
    lazy private var refreshControlTable : UIRefreshControl = {
        let _refreshControl = UIRefreshControl()
        _refreshControl.backgroundColor = UIColor.clear
        _refreshControl.addTarget(self, action: #selector(self.updateTable), for: UIControl.Event.valueChanged)
        return _refreshControl
    }()
    
    @IBInspectable var isPullRefresh : Bool {
        get{
            return true
        }
        set{
            newValue ? (self.refreshControl = self.refreshControlTable) : (self.refreshControl = nil)
        }
    }
    
    @IBInspectable var pullRefreshColor : UIColor {
        get{
            return self.refreshControl?.tintColor ?? .darkGray
        }
        set{
            self.refreshControl?.tintColor = newValue
        }
    }
    
    @objc private func updateTable(){
        self.csmDelegate?.tableView?(self, pullToRefresh: self.refreshControl)
        
    }
    
    override public func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        self.observer = observe(\.contentOffset, options: [.new]) { (model, change) in
            
            if self.contentOffset.y + self.frame.size.height > self.contentSize.height + 40 {
                self.csmDelegate?.tableView?(self, endLessScrollingWithOffset: self.contentOffset)
            }
        }
        
     }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }

}

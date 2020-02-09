//
//  PullReffreshTableViewController.swift
//  PullToRefreshSwift
//
//  Created by Luis Eduardo Hdz on 02/02/20.
//  Copyright © 2020 Luis Eduardo Hdz. All rights reserved.
//

import Foundation

//#import <QuartzCore/QuartzCore.h>
//#import "PullRefreshTableViewController.h"

import QuartzCore
import UIKit
import CoreGraphics

let REFRESH_HEADER_HEIGHT: CGFloat = 52.0

class PullRefreshTableViewController : UITableViewController{

//@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;
//    var textPull: UILabel!
//    var textRelease: UILabel!
//    var textLoading: UILabel!
    
//    var refreshHeaderView: UIView!
//    var refreshLabel: UILabel!
//    var refreshArrow: UIImageView!
//    var refreshSpinner: UIActivityIndicatorView!
//
//    var isDragging:Bool;
//    var isLoading:Bool;
//
//
//    var textPull: NSString!;
//    var textRelease: NSString!;
//    var textLoading: NSString!;
    
    
    var refreshHeaderView: UIView?
    var refreshLabel: UILabel?
    var refreshArrow: UIImageView?
    var refreshSpinner: UIActivityIndicatorView?
    var isDragging: Bool?
    var isLoading: Bool?
    var textPull: String?
    var textRelease: String?
    var textLoading: String?
//    var refreshHeaderView: UIView?
//    var refreshLabel: UILabel?
//    var refreshArrow: UIImageView?
//    var refreshSpinner: UIActivityIndicatorView?
//    var textPull: String?
//    var textRelease: String?
//    var textLoading: String?
    
//    override init(style:UITableView.Style ){
//        self.setupStrings()
//    }
//
//
//
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //fatalError("init(coder:) has not been implemented")
//        self.setupStrings()
//    }
//    encodeWithCoder(_ aCoder: NSCoder) {
//        // Serialize your object here
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupStrings()
    }
    
    init(_ nibNameOrNil: String, bundle nibBundleOrNil: Bundle) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupStrings()
    }
    
//    required init?(coder: NSCoder) {
//        //self.UITableView.init()
//        //self.setupStrings()
//    }
//
//    required init(nibNameOrNil:NSString , bundle:Bundle  ) {
//      self.setupStrings()
//    }
    
    
    override func viewDidLoad() {
        self.addPullToRefreshHeader();
    }

    func setupStrings(){
        textPull = "Pull down to refresh..."
      textRelease = "Release to refresh...";
      textLoading = "Loading...";
    }

    func addPullToRefreshHeader (){
        refreshHeaderView = UIView( frame: CGRect(x: 0, y: 0 - REFRESH_HEADER_HEIGHT, width: 320, height: REFRESH_HEADER_HEIGHT))
        refreshHeaderView?.backgroundColor = UIColor.clear

        refreshLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 320, height: CGFloat(REFRESH_HEADER_HEIGHT)))
        refreshLabel?.backgroundColor = UIColor.clear
        refreshLabel?.font = UIFont.boldSystemFont( ofSize:12.0)
        refreshLabel?.textAlignment = NSTextAlignment.center

        refreshArrow = UIImageView(image:UIImage( named:"arrow.png"))
        refreshArrow?.frame = CGRect(x: floor((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    y: (floor(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    width: 27,height: 44)

        refreshSpinner = UIActivityIndicatorView();
        refreshSpinner?.frame = CGRect(x: floor(floor(REFRESH_HEADER_HEIGHT - 20) / 2), y: floor((REFRESH_HEADER_HEIGHT - 20) / 2), width: 20, height: 20);
        refreshSpinner?.hidesWhenStopped = true;

        refreshHeaderView?.addSubview(refreshLabel!)
        refreshHeaderView?.addSubview(refreshArrow!)
        refreshHeaderView?.addSubview(refreshSpinner!)
        self.tableView.addSubview(refreshHeaderView!)
    }

    override func scrollViewWillBeginDragging( _ scrollView: UIScrollView) {
        if (isLoading!){
            return
        }
        isDragging = true
    }

    func scrollViewDidScroll( scrollView:UIScrollView ) {
        if (isLoading!) {
            // Update the content inset, good for section headers
            if (scrollView.contentOffset.y > 0) {
                self.tableView.contentInset = UIEdgeInsets.zero
            }
            else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT){
                self.tableView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0);
            }
        } else if (isDragging! && scrollView.contentOffset.y < 0) {
            // Update the arrow direction and label
            UIView.animate(withDuration:0.25,animations:{
                if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                    // User is scrolling above the header
                    self.refreshLabel!.text = self.textRelease as String?
                    self.refreshArrow!.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1)
                } else {
                    // User is scrolling somewhere within the header
                    self.refreshLabel!.text = self.textPull as String?
                    self.refreshArrow!.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi * 2), 0, 0, 1)
                }
            });
        }
    }

    func scrollViewDidEndDragging(scrollView:UIScrollView,decelerate:Bool) {
        if (isLoading!) {
            return;
        }
        isDragging = false;
        if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
            // Released above the header
            self.startLoading()
        }
    }

    func startLoading (){
        isLoading = true;
        
        // Show the header
        UIView.animate(withDuration:0.3,animations:{
            self.tableView.contentInset = UIEdgeInsets(top: REFRESH_HEADER_HEIGHT, left: 0, bottom: 0, right: 0);
            self.refreshLabel!.text = self.textLoading as String?;
            self.refreshArrow!.isHidden = true;
            self.refreshSpinner!.startAnimating();
        });
        
        // Refresh action!
        self.refresh();
    }

    @objc func stopLoading() {
        isLoading = false;
        
        // Hide the header
        UIView.animate( withDuration:0.3,
                        animations:{
            self.tableView.contentInset = UIEdgeInsets.zero
                            self.refreshArrow!.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi * 2), 0, 0, 1);
        },completion:{ (finished: Bool) in
            self.perform(#selector(self.stopLoadingComplete))
        });
    }

    @objc func stopLoadingComplete() {
        // Reset the header
        refreshLabel!.text = self.textPull as String?
        refreshArrow!.isHidden = false
        refreshSpinner!.stopAnimating()
    }

    func refresh() {
        // This is just a demo. Override this method with your custom reload action.
        // Don't forget to call stopLoading at the end.
        self.perform(#selector(stopLoading),with:nil,afterDelay:2.0);
    }
    
//    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//        return CGRect(x: x, y: y, width: width, height: height)
//    }
}

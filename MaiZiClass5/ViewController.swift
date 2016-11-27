//
//  ViewController.swift
//  MaiZiClass5
//
//  Created by 叶俊中 on 2016/11/26.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MyScrollImageViewDelegate {
    var myScrollImageView:MyScrollImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myScrollImageView = MyScrollImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300))
        //imageView.seterPage(page: 8)
        var array = [String]()
        for i in 1...8{
            array.append("\(i)")
        }
        myScrollImageView?.seterImget(array: array)
        myScrollImageView?.seterPage(page: array.count)
        self.view.addSubview(myScrollImageView!)
        myScrollImageView?.delegate = self
    }
    func didClickImage(currentPage: Int) {
        myScrollImageView?.stopAnimation()
        let image = UIImage(named: "\(currentPage + 1)")
        let imageView = UIImageView(image:image)
        imageView.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300)
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapp))
        imageView.addGestureRecognizer(tap)
        self.view.addSubview(imageView)
        UIView.animate(withDuration: 0.3){
            () -> Void in
            imageView.frame = self.view.bounds
        }
    }
    
    func tapp(){
        
        UIView.animate(withDuration: 0.3, animations:{
            () -> Void in
            self.view.subviews.last?.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 300)
        }){(finish:Bool) -> Void in
            if finish{
                self.view.subviews.last?.removeFromSuperview()
                self.myScrollImageView?.startAnimation()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


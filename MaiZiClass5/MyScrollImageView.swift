//
//  MyScrollImageView.swift
//  MaiZiClass5
//
//  Created by 叶俊中 on 2016/11/26.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
protocol MyScrollImageViewDelegate {
    func didClickImage(currentPage:Int)
}
class MyScrollImageView: UIView,UIScrollViewDelegate {

    let scrollView : UIScrollView
    let pageControl: UIPageControl
    var pages : Int
    var dataArray : [String]
    var timer:Timer?
    var delegate:MyScrollImageViewDelegate?
    override init(frame: CGRect) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        pageControl = UIPageControl(frame: CGRect(x: 0, y: frame.size.height - 20, width: frame.size.width, height: 20))
        pages = 0
        dataArray = [String]()
        super.init(frame: frame)
        creatView()
    }
    func creatView() {
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.red
        scrollView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapp))
        scrollView.addGestureRecognizer(tap)
        pageControl.addTarget(self, action: #selector(pageChange), for: .valueChanged)
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    func startAnimation(){
        timer?.fireDate = .distantPast
    }
    func stopAnimation(){
        timer?.fireDate = .distantFuture
    }
    func tapp(){
        self.delegate?.didClickImage(currentPage: pageControl.currentPage)
    }
    func time(){
        let offset = scrollView.contentOffset.x
        scrollView.setContentOffset(CGPoint(x:offset + scrollView.frame.size.width,y:0), animated: true)
    }
    func seterPage(page:Int) {
        pages = page
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(page + 2), height: 0)
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        pageControl.numberOfPages = page
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(time), userInfo: nil, repeats: true)
    }
    func seterImget(array:Array<String>){
        dataArray = array
        for i in 0...9{
            var image :UIImage?
            if i == 0 {
                image = UIImage(named: "8")
            }else if i == 9{
                image = UIImage(named:"1")
            }else{
                image = UIImage(named: array[i - 1])
            }
            
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: scrollView.frame.size.width * CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            scrollView.addSubview(imageView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if offset == 0{
            scrollView.contentOffset = CGPoint(x: CGFloat(dataArray.count) * scrollView.frame.size.width, y: 0)
        }else if offset == CGFloat(dataArray.count + 1) * scrollView.frame.size.width{
            scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        }
        let currentoffset = scrollView.contentOffset.x
        let num = currentoffset / scrollView.frame.size.width - 1
        pageControl.currentPage = Int(num)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if offset == 0{
            scrollView.contentOffset = CGPoint(x: CGFloat(dataArray.count) * scrollView.frame.size.width, y: 0)
        }else if offset == CGFloat(dataArray.count + 1) * scrollView.frame.size.width{
            scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        }
        let currentoffset = scrollView.contentOffset.x
        let num = currentoffset / scrollView.frame.size.width - 1
        pageControl.currentPage = Int(num)
    }
    func pageChange() {
        let num = pageControl.currentPage + 1
        scrollView.setContentOffset(CGPoint(x:scrollView.frame.size.width * CGFloat(num),y:0), animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

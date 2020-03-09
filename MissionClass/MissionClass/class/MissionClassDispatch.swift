//
//  MissionClassDispatch.swift
//  MissionClass
//
//  Created by null on 2020/3/9.
//  Copyright © 2020 notblock. All rights reserved.
//

import UIKit

@objcMembers
open class SWMCDispatch : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var table:UITableView? = nil
    
    var data:NSArray?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "dispatch", withExtension: "plist")
        do {
            let tempData = try Data(contentsOf: url!)
            data = try PropertyListSerialization.propertyList(from: tempData, options: [], format: nil) as? NSArray
            
//           let dataUrl = Bundle.main.path(forResource: "dispatch", ofType: "plist")
            
            
        } catch  {
            print(error)
        }
        
        
        table = UITableView(frame: self.view.bounds, style: UITableView.Style.grouped)
        table?.delegate = self
        table?.dataSource = self
        self.view .addSubview(table!)
    }
    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK: UITableViewDelegate
    public func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Int(classmates())
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tempData:NSDictionary = data?[section] as! NSDictionary
        return (tempData.value(forKey: "head") as! String)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = String(format: "同学 %c", charAdd1(Int64(indexPath.row)))
        return cell!;
    }
    
    private func dispatchAsyncToSync() {
        
        let readQueue:DispatchQueue = DispatchQueue(label: "com.notblock.readqueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target:nil);
        let authQueue:DispatchQueue
        
        if #available(iOS 10.0, *) {
            //练习使用initiallyInactive 属性，手动激活队列
            authQueue = DispatchQueue(label: "com.notblock.authqueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.initiallyInactive, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target:nil)
        } else {
            // Fallback on earlier versions
            authQueue = DispatchQueue(label: "com.notblock.authqueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.init(), autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target:nil)
        };
        
        readQueue.async {
            for i in 0...classmates() {
                
            }
        }
        
        authQueue.async {
        
        }
        
        authQueue.async {
            
        }
        
    }
    
    
//    - (void)dispatchAsyncToSync {
//
//    dispatch_queue_t readQueue = dispatch_queue_create("com.notblock.readqueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t authQueue = dispatch_queue_create("com.notblock.authqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_group_t group = dispatch_group_create();
//    LogInfo(@"老师布置背诵任务，全班开始哇哇背诵");
//    for (int i = 0; i < CLASSMATES; i ++) {
//    dispatch_group_enter(group);
//    dispatch_async(readQueue, ^{
//    NSTimeInterval timesBegin = [[NSDate new] timeIntervalSince1970];
//    sleep(3);//在努力记忆
//    NSTimeInterval timesEnd = [[NSDate new] timeIntervalSince1970];
//    LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 开始排队准备背诵 耗时:%f", charAdd(i), timesEnd - timesBegin]);
//    dispatch_async(authQueue, ^{
//    NSTimeInterval tb = [[NSDate new] timeIntervalSince1970];
//    for (int j = 0; j < 1000000000; j ++) {}//在背诵
//    NSTimeInterval te = [[NSDate new] timeIntervalSince1970];
//    LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 背诵完成 耗时:%f", charAdd(i), te - tb]);
//    dispatch_group_leave(group);
//    });
//    });
//    }
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//    LogInfo(@"老师宣布，所有同学背诵完成");
//    });
//    }
}

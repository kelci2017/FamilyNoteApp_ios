//
//  CommonUtil.swift
//  firstproject
//
//  Created by kelci huang on 2018-12-18.
//  Copyright © 2018 kelci huang. All rights reserved.
//

import UIKit

class CommonUtil: NSObject {
    class func image(from view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    
    
    class func scale(image: UIImage?, to size: CGSize, backgroundColor: UIColor = UIColor.clear) -> UIImage? {
        
        guard image != nil else {
            return nil
        }
        
        guard (size.width >= 1) && (size.height >= 1) else {
            
            return nil
            
        }
        
        let imageSize = image!.size
        
        guard (imageSize.width >= 1) && (imageSize.height >= 1) else {
            
            return nil
            
        }
        
        var scaleSize: CGSize = CGSize(width: size.width, height: size.height)
        
        if size.width / size.height > imageSize.width / imageSize.height {
            
            scaleSize.width = imageSize.width / imageSize.height * size.height
            
        }
            
        else {
            
            scaleSize.height = imageSize.height / imageSize.width * size.width
            
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scaleSize.width, height: scaleSize.height))
        
        view.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: view.frame)
        
        view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = image
        
        return self.image(from: view)
    }
    
    class func showDialog(title : String, message : String, viewController : RootViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true, completion: {
                //
            })
        }))
        
        // show the alert
        viewController.present(alert, animated: true, completion: nil)
        
    }
    // MARK: Path of Resource
    
    class func pathOfResource(name: String, ext: String) -> String? {
        let path = Bundle.main.path(forResource: name, ofType: ext)
        return path
    }
    
    // MARK: - Plist
    
    class func getPlist(name: String) -> NSDictionary? {
        let sPath = pathOfResource(name: name, ext: "plist")
        guard sPath != nil else {
            return nil
        }
        let dictPlist = NSDictionary(contentsOfFile: sPath!)
        return dictPlist
    }
    
    // MARK: - Config.plist
    
    fileprivate static var dictConfigPlist: NSDictionary? = nil
    @discardableResult
    class func getConfigPlist() -> NSDictionary? {
        if dictConfigPlist != nil {
            return dictConfigPlist
        }
        
        dictConfigPlist = getPlist(name: "Config")
        
        return dictConfigPlist
    }
    
    fileprivate static var dictConfigTarget: NSDictionary? = nil
    @discardableResult
    class func getConfigTarget() -> NSDictionary? {
        if dictConfigTarget != nil {
            return dictConfigTarget
        }
        
        if dictConfigPlist == nil {
            getConfigPlist()
        }
        guard dictConfigPlist != nil else {
            return nil
        }
        
        let dictTarget = dictConfigPlist!["Target"] as? NSDictionary
        guard dictTarget != nil else {
            return nil
        }
        
        let index = dictTarget!["Index"] as? Int ?? 0
        let arrOptions = dictTarget!["Options"] as? NSArray
        guard (arrOptions != nil) && (arrOptions!.count > 0) else {
            return nil
        }
        
        dictConfigTarget = arrOptions![index] as? NSDictionary
        
        return dictConfigTarget
    }
    
    fileprivate static var sTargetName: NSString? = nil
    class func getTargetName() -> NSString? {
        if sTargetName != nil {
            return sTargetName
        }
        
        if dictConfigTarget == nil {
            getConfigTarget()
        }
        guard dictConfigTarget != nil else {
            return nil
        }
        
        sTargetName = dictConfigTarget!["Name"] as? NSString
        
        return sTargetName
    }
    
    fileprivate static var sStartingView: NSString? = nil
    class func getStartingView() -> NSString? {
        if sStartingView != nil {
            return sStartingView
        }
        
        if dictConfigTarget == nil {
            getConfigTarget()
        }
        guard dictConfigTarget != nil else {
            return nil
        }
        
        let dictUI = dictConfigTarget!["UI"] as? NSDictionary
        guard dictUI != nil else {
            return nil
        }
        
        let dictStartingView = dictUI!["StartingView"] as? NSDictionary
        guard dictStartingView != nil else {
            return nil
        }
        
        let index = dictStartingView!["Index"] as? Int ?? 0
        let arrOptions = dictStartingView!["Options"] as? NSArray
        guard (arrOptions != nil) && (arrOptions!.count > 0) else {
            return nil
        }
        
        sStartingView = arrOptions![index] as? NSString
        
        return sStartingView
    }
    
    fileprivate static var sNavigationBarBackgroundColorCode: NSString? = nil
    class func getNavigationBarBackgroundColorCode() -> NSString? {
        if sNavigationBarBackgroundColorCode != nil {
            return sNavigationBarBackgroundColorCode
        }
        
        if dictConfigTarget == nil {
            getConfigTarget()
        }
        guard dictConfigTarget != nil else {
            return nil
        }
        
        let dictUI = dictConfigTarget!["UI"] as? NSDictionary
        guard dictUI != nil else {
            return nil
        }
        
        let dictColors = dictUI!["Colors"] as? NSDictionary
        guard dictColors != nil else {
            return nil
        }
        
        let dictNavigationBar = dictColors!["NavigationBar"] as? NSDictionary
        guard dictNavigationBar != nil else {
            return nil
        }
        
        sNavigationBarBackgroundColorCode = dictNavigationBar!["BackgroundColor"] as? NSString
        
        return sNavigationBarBackgroundColorCode
    }
    
    fileprivate static var sNavigationBarForegroundColorCode: NSString? = nil
    class func getNavigationBarForegroundColorCode() -> NSString? {
        if sNavigationBarForegroundColorCode != nil {
            return sNavigationBarForegroundColorCode
        }
        
        if dictConfigTarget == nil {
            getConfigTarget()
        }
        guard dictConfigTarget != nil else {
            return nil
        }
        
        let dictUI = dictConfigTarget!["UI"] as? NSDictionary
        guard dictUI != nil else {
            return nil
        }
        
        let dictColors = dictUI!["Colors"] as? NSDictionary
        guard dictColors != nil else {
            return nil
        }
        
        let dictNavigationBar = dictColors!["NavigationBar"] as? NSDictionary
        guard dictNavigationBar != nil else {
            return nil
        }
        
        sNavigationBarForegroundColorCode = dictNavigationBar!["ForegroundColor"] as? NSString
        
        return sNavigationBarForegroundColorCode
    }
    
    class func getCurrentMonthDays() -> Int {
        let calendar = Calendar.current
        let date = Date()
        
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date)! //change year it will no of days in a year , change it to month it will give no of days in a current month
        
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return days

    }
    
    class func generateDate(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        
        return date
    }
}

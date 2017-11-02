
import Foundation
import  UIKit
import SystemConfiguration

public class Utility{
    
    static var longDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static var timeFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    class func isEmptyString(str:String)->Bool {
        let trimmed = str.trimmingCharacters(in: NSCharacterSet.whitespaces)
        return trimmed.isEmpty
    }
    

//    class func showProgressHud(text : String)
//    {
//        if (hud == nil)
//        {
//            hud = MBProgressHUD.init(window: UIApplication.shared.keyWindow!)
//            UIApplication.shared.keyWindow?.addSubview(hud)
//            hud.show(animated: true)
//            hud.label.text = text
//        }
//        else
//        {
//             DispatchQueue.main.async(execute: {
//                //Hide progress view
//                if (hud != nil)
//                {
//                    hud.label.text = text
//                }
//            })
//        }
//    }
//    
//    
//  
//    class func hideProgressHud()
//    {
//        if(hud != nil) {
//            hud.hide(animated: true)
//            hud.removeFromSuperview()
//            hud.delegate = nil
//            hud = nil
//        }
//    }
//    
//    class func showToast(text : String){
//        if (hud == nil)
//        {
//            hud = MBProgressHUD.init(window: UIApplication.shared.keyWindow!)
//            hud.mode = .text
//            UIApplication.shared.keyWindow?.addSubview(hud)
//            hud.removeFromSuperViewOnHide = true;
//            hud.label.text = text
//            hud.show(animated: true)
//            hud.hide(animated: true, afterDelay: 3)
//            
//        }
//        else
//        {
//            DispatchQueue.main.async(execute: {
//                //Hide progress view
//                if (hud != nil)
//                {
//                    hud.label.text = text
//                }
//            })
//        }
//    }
    
    
    
    class func showAlertWithInfo(infoDic : NSDictionary)
    {
        var tag : Int = 0
        
        if (infoDic.object(forKey: "tag") != nil) {
            tag = ((infoDic.object(forKey: "tag") as AnyObject).integerValue)!
        }
        
        let alertView : UIAlertView = UIAlertView.init(title: infoDic.object(forKey: "title") as? String, message: infoDic.object(forKey: "message")as? String, delegate: infoDic.object(forKey: "delegate") as? UIAlertViewDelegate, cancelButtonTitle: infoDic.object(forKey: "cancel")as? String)
        alertView.tag = tag
        alertView.show()
    }
    
    
    class func showAlertWithMultiButtonInfo(infoDic : NSDictionary)
    {
        var tag : Int = 0
        
        if (infoDic.object(forKey: "tag") != nil) {
            tag = ((infoDic.object(forKey: "tag") as AnyObject).integerValue)!
        }
        
        let alertView : UIAlertView = UIAlertView.init(title: infoDic.object(forKey: "title") as! String, message: infoDic.object(forKey: "message") as! String, delegate: infoDic.object(forKey: "delegate") as? UIAlertViewDelegate, cancelButtonTitle: infoDic.object(forKey: "cancel")as? String, otherButtonTitles: infoDic.object(forKey: "ok")as! String)
        alertView.tag = tag
        alertView.show()
    }
    
    class func isNameValid(inputString : String) -> Bool
    {
        let letters = NSCharacterSet.letters
        let range = inputString.rangeOfCharacter(from: letters)
        
        // range will be nil if no letters is found
        if range != nil {
            return true
        }
        else {
            return false
        }
    }
    
}





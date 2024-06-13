import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        let batteryChannel = FlutterMethodChannel(
            name: "com.glootea.queueminder/share",
            binaryMessenger: flutterViewController.engine.binaryMessenger)
        batteryChannel.setMethodCallHandler { (call, result) in
            
            if(call.method == "share") {
                let sendArgument = (call.arguments as! [String:String])["text"]
                guard let sendString = sendArgument else {
                    result("Passed string in null")
                    return
                }
                
                self.sendStringViaAirDrop(sendString)
                result("Success")
                return
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
        }
    
      
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
    
    func sendStringViaAirDrop(_ string: String) {
		let airDropService = NSSharingServicePicker(items: [URL(string: string) as AnyObject])
		airDropService.show(relativeTo: self.contentLayoutRect, of: self.contentView!, preferredEdge: NSRectEdge(rectEdge: CGRectEdge.minXEdge))
    }
}

# Pulse Insights iOS SDK(SPM)

## Installation

To install Pulse Insights in your application, follow these steps:

### Using Swift Package Manager

1. Open your project in Xcode:

Go to `File` > `Swift Packages` > `Add Package Dependency...`

2. Enter the repository URL: 

 - Paste the following URL: https://github.com/Pulse-Insights/pi-ios-spm

3. Choose the version:

Select the version you want to install. We recommend using the latest release for the most up-to-date features and bug fixes.

4. Add the package:

Xcode will automatically resolve the package and add it to your project.

### Manual Installation

1. Clone the repository:

Run the following command in your terminal:

```
git clone https://github.com/Pulse-Insights/pi-ios-spm.git
```

2. Add the source files to your project:

- Drag and drop the PulseInsights folder into your Xcode project.

3. Link necessary frameworks:

Ensure that your project links the required frameworks such as UIKit and CoreMotion.

## Upgrading

### Using Swift Package Manager

1. Open your project in Xcode:

Go to `File` > `Swift Packages` > `Update to Latest Package Versions`.

2. Select the Pulse Insights package:

- Xcode will check for the latest version and update it automatically.

### Manual Upgrade

1. Pull the latest changes:

- Navigate to the cloned repository directory and run:

```
git pull origin main
```

2. Replace the old files:

- Replace the existing `PulseInsights` folder in your project with the updated one from the repository.

3. Rebuild your project:

- Clean and build your project to ensure all changes are applied.

## Usage

### 1. Initialization

First, configure the shared PulseInsights object inside AppDelegate. You’ll do the following:

* Include the necessary headers.
* Setup the PulseInsights object inside didFinishLaunchingWithOptions.
* Replace YOUR_ACCOUNT_ID with your own PulseInsights ID, for example PI-12345678.

First add PulseInsights inside `AppDelegate`:

```swift4.2
import PulseInsights
```

Then, override the `didFinishLaunchingWithOptions` method:

```swift4.2
// Optional: set enableDebugMode to true for debug information.

let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, enableDebugMode:[Bool value])
```

### 2. View tracking

PulseInsights allows targeting surveys to a given screen name. In order for the SDK to know the current screen name, you can use the following method to notify  it of the current screen name change:

```swift4.2
PulseInsights.getInstance.setViewName(viewName:String,
controller:UIViewController)
```

For example, you can override the viewDidAppear function on the UIViewController subclass:

```swift4.2
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    PulseInsights.getInstance.setViewName("MainView", controller: self)
}
```

### 3. Survey polling

The PulseInsights SDK will automatically regularly fetch surveys that would match various targeting conditions, based on a frequency that you can override as shown below:

```swift4.2
PulseInsights.getInstance.setScanFrequency(setFrequencyInSecond :NSInteger)
```

If you want to manually fetch new surveys, you can also use this method:

```swift4.2
PulseInsights.getInstance.serve()
```

### 4. Render a specific survey

It's also possible to manually trigger a survey by its id:

```swift4.2
PulseInsights.getInstance.present(surveyID:String)
```  

### 5. Inline surveys

Inline surveys are rendered within the content of the application, instead of overlaying the application content.

In order to integrate inline surveys, you can programmatically create the `InlineSurveyView` object by assigning an identifier and inserting it into a view:

```swift4.2
var inlineSurveyView:InlineSurveyView?

inlineSurveyView = InlineSurveyView(identifier: String)

self.view.addSubview(inlineSurveyView)
```

If you integrate `InlineSurveyView` with the nib/xib, you can assign the tracking identifier by using the method `setIdentifier`

```swift4.2
override func viewDidLoad() {
        super.viewDidLoad()
        inlineSurveyView?.setIdentifier(className: String) // assume the inlineSurveyView have been initialized
}
```

Here's another example of assigning the identifier for the inline view from xib

```swift4.2
@IBOutlet weak var inlineXibView: InlineSurveyView! {
        didSet {
            inlineXibView?.setIdentifier("InlineXib")
        }
    }
```

If you prefer, setup the identifier with the nib layout, as the following screenshot shows. You can find the `Identifier` attribute from the Xcode interface

![Xcode interface](Develop/res/pi-inline-nib.png "Identifier")

### 6. Survey rendering

You can pause and resume the survey rendering feature with the following method:

```swift4.2
PulseInsights.getInstance.switchSurveyScan(boolean enable);
```

And check the current configuration with the following method:
- true: survey rendering feature is enabled
- false: survey rendering feature is paused

```swift4.2
var renderingConfig: Bool = PulseInsights.getInstance.isSurveyScanWorking();
```

It's also possible to pause the survey rendering from the initialization of the Pulse Insights library:

```swift4.2
let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, automaticStart: ${Bool value})
```

### 7. Client Key

Client key can be setup using this method:
```swift4.2
PulseInsights.getInstance.setClientKey(_ clientId: String )
```

The configured client key can be fetched with this method:
```swift4.2
let getKey: String = PulseInsights.getInstance.getClientKey()
```

### 8. Preview mode

Preview mode can be enabled/disabled by:
```
Shaking the device more than 10-times in 3-seconds
```

Preview mode can be programmatically enabled/disabled by this method:
```swift4.2
PulseInsights.getInstance.setPreviewMode(_ enable: Bool)
```

It's also possible to set preview mode from the initialization of the Pulse Insights library:
```swift4.2
let pi:PulseInsights = PulseInsights(_ accountID:String, enableDebugMode:Bool = false, previewMode:Bool = false)
```

In order to check the status of preview mode, use this method:
```swift4.2
let isPreviewModeOn: Bool = PulseInsights.getInstance.isPreviewModeOn()
```

### 9. Callbacks

If you want to know if a survey has been answered by the current device, this method can be used:
```swift4.2
let isSurveyAnswered: Bool = PulseInsights.getInstance.checkSurveyAnswered(_ surveyId: String )
```

It's also possible to configure a callback to be executed when a survey has been answered:

```swift4.2
class ViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      PulseInsights.getInstance.setSurveyAnsweredListener(self)
    }

}
extension ViewController: SurveyAnsweredListener {
    func onAnswered(_ answerId: String) {

    }
}
```

### 10. Context data

You can save context data along with the survey results, or for a refined survey targeting, using the `customData` config attribute, for example:

```Swift4.2
let pi:PulseInsights = PulseInsights(YOUR_ACCOUNT_ID, customData: ["gender": "male", "age": "32", "locale": "en-US"])
```

You can also use method `setContextData` to add or update these data as follows:

```Swift
PulseInsights.getInstance.setContextData(["author": "Ann Smith", "variant": "a"])
``` 

If using Context Data for targeting, it should be defined before `PulseInsights.getInstance.serve()`, since that line triggers the evaluation for whether to return a survey on the current pageview.

### 11. Device data

If you want to set device data, which will be saved along the survey results, the method `setDeviceData` can be used as follows:

```Swift4.2
PulseInsights.getInstance.setDeviceData(dictData:[String: String]())
```

`setDeviceData` can be called at any time. It will trigger a separate network request to save the data.

### 12. Advanced usage

The default host is "survey.pulseinsights.com". If you want to target the staging environment, or any other environment, it's possible to override the default host:

```swift4.2
PulseInsights.getInstance.setHost(hostName:String)
```

The debug mode can be turned on and off:

```swift4.2
PulseInsights.getInstance.setDebugMode(enable:Bool)
```

PulseInsights creates a unique UDID to track a given device. If you wish to reset this UDID, you can call the following method:

```swift4.2
PulseInsights.getInstance.resetUdid()
```

If you want manually config the view controller, you can call the following method:

```swift4.2
PulseInsights.getInstance.setViewController(ontroller: UIViewController)
```

And get the view controller object that has been configured.

```swift4.2
let viewController: UIViewController = PulseInsights.getInstance.getViewController()
```


## Uninstall

### Using Swift Package Manager

1. Open your project in Xcode:

Go to `File` > `Swift Packages` > `Manage Packages...`

2. Remove the package:

Select the Pulse Insights package and click the - button to remove it.

3. Clean your project:

Go to `Product` > `Clean Build Folder` to remove any cached data.

### Manual Uninstallation

1. Remove the source files:

Delete the `PulseInsights` folder from your Xcode project.

2. Unlink frameworks:

Go to your project settings and remove any linked frameworks that were added for Pulse Insights.

3. Clean your project:

Go to `Product` > `Clean Build Folder` to ensure all references are removed.

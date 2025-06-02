# PalmID SDK iOS Example

This is a simple example of how to use the PalmID SDK.

## Configuration

1. add the following permissions to your `Info.plist` file:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera permission is required for PalmID SDK</string>
```

2. add the following to your `Podfile` file:

```ruby
# You must include the palm native podspec source below.
source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com:redrockbiometrics/palmid-sdk-cocopods.git'

pod 'PalmIDNativeSDK', 'latest.version'
```

3. add the following to your `AppDelegate` file:

```swift
PalmIDNativeSDK.sharedInstance().initialize(withEntrypoint: entrypoint, partnerId: partnerId, projectId: projectId, accessToken: accessToken) { success in
            print("init sdk result: \(success)")
}
```

3.1 Parameters

| Parameter | Required | Description |
|------------|-------------|-------------|
| entrypoint | Yes | The entrypoint of the PalmID SDK. |
| partnerId | Yes | The partnerId of the PalmID SDK. |
| projectId | Yes | The projectId of the PalmID SDK. |
| accessToken | No | The accessToken of the PalmID SDK. If not provided, it will be automatically generated using partnerId and projectId. |
| requiredEnrollmentScans | No | Required number of scans for enrollment |

## Result Error Codes

| Description | Error Code |
|------------|-------------|
| SuccessException          | 100000  |
| UserCancelledException    | -1      |
| AuthenticationException   | 100001  |
| UserNotFoundException     | 100002  |
| NoMatchUserException      | 100003  |
| UserAlreadyExistsException| 100004  |
| EnrollException           | 100005  |
| IdentifyException         | 100006  |
| VerifyException           | 100007  |
| DeleteUserException       | 100008  |
| OtherException            | 999999  |
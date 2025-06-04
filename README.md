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

## API Reference

```c
/**
 * Initializes the PalmID SDK engine with required credentials and configuration.
 *
 * @param entrypoint       (Optional) Custom backend API endpoint URL. Pass `nil` to use the default endpoint.
 * @param partnerId        (Required) Partner identifier for authentication. Must not be `nil`.
 * @param projectId        (Required) Project identifier for service segregation. Must not be `nil`.
 * @param accessToken      (Optional) Access token for authentication. Pass `nil` to use the default token.
 * @param requiredEnrollmentScans (Optional) Required number of scans for enrollment. Pass `nil` if not required.
 * @param completion       Callback block with initialization result (success/failure).
 */
- (void)initializeWithEntrypoint:(NSString * _Nullable)entrypoint
                       partnerId:(NSString * _Nonnull)partnerId
                       projectId:(NSString * _Nonnull)projectId
                       accessToken:(NSString * _Nullable)accessToken
                       requiredEnrollmentScans:(NSNumber * _Nullable)requiredEnrollmentScans
                      completion:(PalmIDNativeSDKCompletion)completion;

/**
 * Verifies a user's palm print against a registered palm ID.
 *
 * @param palmId              Pre-registered palm identifier to verify against.
 * @param navigationController Host navigation controller for presenting verification UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with verification result (success/failure and metadata).
 */
- (void)verifyWithPalmId:(NSString *)palmId
    navigationController:(UINavigationController *)navigationController
          loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                  result:(PalmIDNativeSDKResultBlock)block;

/**
 * Identifies a user by capturing and matching their palm print.
 *
 * @param navigationController Host navigation controller for presenting capture UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with identification result (matched palm ID or error).
 */
- (void)identifyWithNavigationController:(UINavigationController *)navigationController
                          loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                                  result:(PalmIDNativeSDKResultBlock)block;

/**
 * Enrolls a new user by capturing and registering their palm print.
 *
 * @param navigationController Host navigation controller for presenting enrollment UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with enrollment result (success/failure status).
 */
- (void)enrollWithNavigationController:(UINavigationController *)navigationController
                        loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                                result:(PalmIDNativeSDKResultBlock)block;

/**
 * Removes a registered user from the palm recognition system.
 *
 * @param palmId Unique identifier of the user to be removed.
 * @param block  Callback block with deletion result (success/failure status).
 */
- (void)deleteUser:(NSString *)palmId result:(PalmIDNativeSDKResultBlock)block;

/**
 * Release engine
 *
 * 1. Can be called multiple times
 * 2. If the initialization parameter [autoReleaseEngine] is YES, this method does not need to be called.
 */
- (void) releaseEngine;
```

### PalmIDNativeResult

```c
@interface PalmIDNativeResultData : NSObject
@property (nonatomic, copy) NSString *palmId;
@property (nonatomic, assign) double score;
@end

@interface PalmIDNativeResult : NSObject
@property (nonatomic, assign) int errorCode;
@property (nonatomic, strong) PalmIDNativeResultData *data;
@end
```
### errorCode

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
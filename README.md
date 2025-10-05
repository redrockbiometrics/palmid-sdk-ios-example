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

pod 'PalmIDNativeSDK', '1.4.0'
```

## API Reference

```c
/**
 * Initializes the PalmID SDK engine with required credentials and configuration.
 *
 * @param requiredEnrollmentScans (Optional) Required number of scans for enrollment. Pass `nil` if not required.
 * @param completion       Callback block with initialization result (success/failure).
 */
- (void)initializeWithRequiredEnrollmentScans:(NSNumber * _Nullable)requiredEnrollmentScans
                      completion:(PalmIDNativeSDKCompletion)completion;

/**
 * Initializes the PalmID SDK engine with required credentials and configuration.
 *
 * @param palmServerEntrypoint       (Optional) Custom backend API endpoint URL. Pass `nil` to use the default endpoint.
 * @param appServerEntrypoint       (Optional) Custom backend API endpoint URL. Pass `nil` to use the default endpoint.
 * @param projectId        (Required) Project identifier for service segregation. Must not be `nil`.
 * @param requiredEnrollmentScans (Optional) Required number of scans for enrollment. Pass `nil` if not required.
 * @param completion       Callback block with initialization result (success/failure).
 */
- (void)initializeWithPalmServerEntrypoint:(NSString * _Nullable)palmServerEntrypoint
                       appServerEntrypoint:(NSString * _Nullable)appServerEntrypoint
                       projectId:(NSString * _Nonnull)projectId
                       requiredEnrollmentScans:(NSNumber * _Nullable)requiredEnrollmentScans
                      completion:(PalmIDNativeSDKCompletion)completion;

/**
 * Verifies a user's palm print.
 *
 * @param viewController Host viewcontroller for presenting verification UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with verification result (success/failure and metadata).
 */
- (void)verifyWithViewController:(UIViewController *)viewController
          loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                  result:(PalmIDNativeSDKResultBlock)block;

/**
 * Verifies a user's palm print against a registered user ID.
 *
 * @param userId              Pre-registered palm identifier to verify against.
 * @param viewController Host viewcontroller for presenting verification UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with verification result (success/failure and metadata).
 */
- (void)verifyWithUserId:(NSString *)userId
          viewController:(UIViewController *)viewController
          loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                  result:(PalmIDNativeSDKResultBlock)block;

/**
 * Identifies a user by capturing and matching their palm print.
 *
 * @param viewController Host viewcontroller for presenting capture UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with identification result (matched palm ID or error).
 */
- (void)identifyWithViewController:(UIViewController *)viewController
                          loadController:(PalmIDNativeSDKLoadController * _Nullable)loadController
                                  result:(PalmIDNativeSDKResultBlock)block;

/**
 * Enrolls a new user by capturing and registering their palm print.
 *
 * @param viewController Host viewcontroller for presenting enrollment UI.
 * @param loadController      (Optional) Custom loading UI controller. Pass `nil` for default UI.
 * @param block               Callback block with enrollment result (success/failure status).
 */
- (void)enrollWithViewController:(UIViewController *)viewController
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
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) double score;
@property (nonatomic, copy) NSString *sessionId; // Only has value when appServerEntrypoint is specified during initialization
@end

@interface PalmIDNativeResult : NSObject
@property (nonatomic, assign) int errorCode;
@property (nonatomic, copy) NSString *errorMsg;
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
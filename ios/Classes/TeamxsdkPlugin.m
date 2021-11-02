#import "TeamxsdkPlugin.h"
#if __has_include(<teamxsdk/teamxsdk-Swift.h>)
#import <teamxsdk/teamxsdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "teamxsdk-Swift.h"
#endif

@implementation TeamxsdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTeamxsdkPlugin registerWithRegistrar:registrar];
}
@end

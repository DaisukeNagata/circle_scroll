#import "CircleScrollPlugin.h"
#if __has_include(<circle_scroll/circle_scroll-Swift.h>)
#import <circle_scroll/circle_scroll-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "circle_scroll-Swift.h"
#endif

@implementation CircleScrollPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCircleScrollPlugin registerWithRegistrar:registrar];
}
@end

#import "CaptureAndSharePlugin.h"

@implementation CaptureAndSharePlugin

FlutterViewController *controller = nil;
UIWindow *keyWindow = nil;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"capture_and_share"
            binaryMessenger:[registrar messenger]];

  keyWindow = [[[UIApplication sharedApplication] delegate] window];
  controller = (FlutterViewController*)keyWindow.rootViewController;

  CaptureAndSharePlugin* instance = [[CaptureAndSharePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"shareIt" isEqualToString:call.method]) {
      NSNumber *sizeWidth = call.arguments[@"sizeWidth"];
      NSNumber *sizeHeight = call.arguments[@"sizeHeight"];
      NSString *xMode = call.arguments[@"xMode"];
      NSString *yMode = call.arguments[@"yMode"];

      [self shareIt: (controller.view) sizeWidth:(sizeWidth.floatValue) sizeHeight:(sizeHeight.floatValue) xMode:(xMode) yMode:(yMode)];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (float)getWidth:(UIView*)view sizeWidth:(float)sizeWidth {
    CGFloat boxWidth;

    if (sizeWidth <= 0) {
      boxWidth = CGRectGetWidth(controller.view.bounds);
    }else{
      boxWidth = sizeWidth;
    }

    return boxWidth;
}

- (float)getHeight:(UIView*)view sizeHeight:(float)sizeHeight {
    CGFloat boxHeight;

    if (sizeHeight <= 0) {
      boxHeight = CGRectGetHeight(controller.view.bounds);
    }else{
      boxHeight = sizeHeight;
    }

    return boxHeight;
}

- (UIImage *)createAndCrop:(UIView*)view boxWidth:(CGFloat)boxWidth boxHeight:(CGFloat)boxHeight xPosition:(float)xPosition yPosition:(float)yPosition {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(boxWidth, boxHeight), controller.view.opaque, 0.0f);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, -xPosition, -yPosition);

    [controller.view drawViewHierarchyInRect:controller.view.bounds afterScreenUpdates:YES];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

- (float)getXPosition:(UIView*)view sizeWidth:(float)sizeWidth xMode:(NSString*)xMode {
    float x;
    float deviceWidth = controller.view.bounds.size.width;
    
    if (sizeWidth <= 0) {
        x = 0;
    } else {
        if ([xMode isEqualToString:@"left"]){
            x = 0;
        }else if([xMode isEqualToString:@"right"]){
            x = deviceWidth - sizeWidth;
        }else{ // center
            x = (deviceWidth/2) - (sizeWidth/2);
        }
    }

    return  x;
}

- (float)getYPosition:(UIView*)view sizeHeight:(float)sizeHeight yMode:(NSString*)yMode {
    float y;
    float deviceHeight = controller.view.bounds.size.height;
    
    if (sizeHeight <= 0){
        y = 0;
    } else {
        if ([yMode isEqualToString:@"top"]){
            y = 0;
        }else if([yMode isEqualToString:@"bottom"]){
            y = deviceHeight - sizeHeight;
        }else{ // center
            y = (deviceHeight/2) - (sizeHeight/2);
        }
    }

    return  y;
}

- (void)shareIt:(UIView*)view sizeWidth:(float)sizeWidth sizeHeight:(float)sizeHeight xMode:(NSString*)xMode yMode:(NSString*)yMode {
    CGFloat boxWidth = [self getWidth:(controller.view) sizeWidth:(sizeWidth)];
    CGFloat boxHeight = [self getHeight:(controller.view) sizeHeight:(sizeHeight)];

    float x = [self getXPosition:(controller.view) sizeWidth:(sizeWidth) xMode:(xMode)];
    float y = [self getYPosition:(controller.view) sizeHeight:(sizeHeight) yMode:(yMode)];

    UIImage *img = [self createAndCrop:(controller.view) boxWidth:(boxWidth) boxHeight:(boxHeight) xPosition:(x) yPosition:(y)];

    NSArray *items = @[img];

    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [controller presentViewController:avc animated: YES completion:nil];
}

@end

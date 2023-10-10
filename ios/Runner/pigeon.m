// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "pigeon.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

NSObject<FlutterMessageCodec> *CommonDetailsApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void CommonDetailsApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommonDetailsApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.registration_client.CommonDetailsApi.getTemplateContent"
        binaryMessenger:binaryMessenger
        codec:CommonDetailsApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getTemplateContentTemplateName:langCode:completion:)], @"CommonDetailsApi api (%@) doesn't respond to @selector(getTemplateContentTemplateName:langCode:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_templateName = GetNullableObjectAtIndex(args, 0);
        NSString *arg_langCode = GetNullableObjectAtIndex(args, 1);
        [api getTemplateContentTemplateName:arg_templateName langCode:arg_langCode completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.registration_client.CommonDetailsApi.getPreviewTemplateContent"
        binaryMessenger:binaryMessenger
        codec:CommonDetailsApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getPreviewTemplateContentTemplateTypeCode:langCode:completion:)], @"CommonDetailsApi api (%@) doesn't respond to @selector(getPreviewTemplateContentTemplateTypeCode:langCode:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_templateTypeCode = GetNullableObjectAtIndex(args, 0);
        NSString *arg_langCode = GetNullableObjectAtIndex(args, 1);
        [api getPreviewTemplateContentTemplateTypeCode:arg_templateTypeCode langCode:arg_langCode completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.registration_client.CommonDetailsApi.getDocumentTypes"
        binaryMessenger:binaryMessenger
        codec:CommonDetailsApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDocumentTypesCategoryCode:applicantType:langCode:completion:)], @"CommonDetailsApi api (%@) doesn't respond to @selector(getDocumentTypesCategoryCode:applicantType:langCode:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_categoryCode = GetNullableObjectAtIndex(args, 0);
        NSString *arg_applicantType = GetNullableObjectAtIndex(args, 1);
        NSString *arg_langCode = GetNullableObjectAtIndex(args, 2);
        [api getDocumentTypesCategoryCode:arg_categoryCode applicantType:arg_applicantType langCode:arg_langCode completion:^(NSArray<NSString *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.registration_client.CommonDetailsApi.getFieldValues"
        binaryMessenger:binaryMessenger
        codec:CommonDetailsApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getFieldValuesFieldName:langCode:completion:)], @"CommonDetailsApi api (%@) doesn't respond to @selector(getFieldValuesFieldName:langCode:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_fieldName = GetNullableObjectAtIndex(args, 0);
        NSString *arg_langCode = GetNullableObjectAtIndex(args, 1);
        [api getFieldValuesFieldName:arg_fieldName langCode:arg_langCode completion:^(NSArray<NSString *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.registration_client.CommonDetailsApi.saveVersionToGlobalParam"
        binaryMessenger:binaryMessenger
        codec:CommonDetailsApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(saveVersionToGlobalParamId:value:completion:)], @"CommonDetailsApi api (%@) doesn't respond to @selector(saveVersionToGlobalParamId:value:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_id = GetNullableObjectAtIndex(args, 0);
        NSString *arg_value = GetNullableObjectAtIndex(args, 1);
        [api saveVersionToGlobalParamId:arg_id value:arg_value completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}

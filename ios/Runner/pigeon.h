// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN


/// The codec used by BiometricsApi.
NSObject<FlutterMessageCodec> *BiometricsApiGetCodec(void);

@protocol BiometricsApi
- (void)invokeDiscoverSbiFieldId:(NSString *)fieldId modality:(NSString *)modality completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)getBestBiometricsFieldId:(NSString *)fieldId modality:(NSString *)modality completion:(void (^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion;
- (void)getBiometricsFieldId:(NSString *)fieldId modality:(NSString *)modality attempt:(NSNumber *)attempt completion:(void (^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion;
- (void)extractImageValuesFieldId:(NSString *)fieldId modality:(NSString *)modality completion:(void (^)(NSArray<FlutterStandardTypedData *> *_Nullable, FlutterError *_Nullable))completion;
- (void)extractImageValuesByAttemptFieldId:(NSString *)fieldId modality:(NSString *)modality attempt:(NSNumber *)attempt completion:(void (^)(NSArray<FlutterStandardTypedData *> *_Nullable, FlutterError *_Nullable))completion;
- (void)incrementBioAttemptFieldId:(NSString *)fieldId modality:(NSString *)modality completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)getBioAttemptFieldId:(NSString *)fieldId modality:(NSString *)modality completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)setCommentFieldId:(NSString *)fieldId modality:(NSString *)modality comment:(NSString *)comment completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)startOperatorOnboardingWithCompletion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)saveOperatorBiometricsWithCompletion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)addBioExceptionFieldId:(NSString *)fieldId modality:(NSString *)modality attribute:(NSString *)attribute completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)removeBioExceptionFieldId:(NSString *)fieldId modality:(NSString *)modality attribute:(NSString *)attribute completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)getMapValueKey:(NSString *)key completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)getAgeGroupWithCompletion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)conditionalBioAttributeValidationFieldId:(NSString *)fieldId expression:(NSString *)expression completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void BiometricsApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BiometricsApi> *_Nullable api);

NS_ASSUME_NONNULL_END

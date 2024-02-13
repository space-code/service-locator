//
// ServiceLocatorTests
// Copyright © 2024 Space Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "DummyProtocol.h"
#import "NVRegistry.h"

@interface NVRegistryTests : XCTestCase

@property(nonatomic, strong) NVRegistry *sut;

@end

@implementation NVRegistryTests

#pragma mark - XCTestCase

- (void)setUp {
  [super setUp];
  _sut = [NVRegistry sharedInstance];
}

- (void)tearDown {
  _sut = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)test_thatRegistryResolvesSingletonObjects {
  // given
  [_sut register:@protocol(DummyProtocol)
           scope:NVRegistryScopeSignleton
         factory:^id _Nonnull {
           return [self makeClass:@"Class"];
         }];

  // when
  id obj1 = [_sut resolve:@protocol(DummyProtocol)];
  id obj2 = [_sut resolve:@protocol(DummyProtocol)];

  // when
  XCTAssertEqual(obj1, obj2);
}

- (void)test_thatRegistryResolvesPrototypeObjects {
  // given
  [_sut register:@protocol(DummyProtocol)
           scope:NVRegistryScopePrototype
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName"];
         }];

  // when
  id obj1 = [_sut resolve:@protocol(DummyProtocol)];
  id obj2 = [_sut resolve:@protocol(DummyProtocol)];

  // when
  XCTAssertNotEqual(obj1, obj2);
}

- (void)test_thatRegistryResolvesAFewObjectsWithDifferentProtocols {
  // given
  [_sut register:[self makeProtocol:@"ProtocolName1"]
           scope:NVRegistryScopePrototype
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName1"];
         }];
  [_sut register:[self makeProtocol:@"ProtocolName2"]
           scope:NVRegistryScopePrototype
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName2"];
         }];

  // when
  id obj1 = [_sut resolve:[self makeProtocol:@"ProtocolName1"]];
  id obj2 = [_sut resolve:[self makeProtocol:@"ProtocolName2"]];

  // when
  XCTAssertNotEqual(obj1, obj2);
  XCTAssertEqualObjects(NSStringFromClass([obj1 class]), @"ClassName1");
  XCTAssertEqualObjects(NSStringFromClass([obj2 class]), @"ClassName2");
}

- (void)test_thatRegistryResolvesLastRegisteredObject {
  // given
  [_sut register:@protocol(DummyProtocol)
           scope:NVRegistryScopePrototype
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName1"];
         }];
  [_sut register:@protocol(DummyProtocol)
           scope:NVRegistryScopeSignleton
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName2"];
         }];

  // when
  id obj1 = [_sut resolve:@protocol(DummyProtocol)];
  id obj2 = [_sut resolve:@protocol(DummyProtocol)];

  // when
  XCTAssertEqual(obj1, obj2);
  XCTAssertEqualObjects(NSStringFromClass([obj1 class]), @"ClassName2");
}

- (void)test_thatRegistryRemovesRegisteredObject {
  // given
  [_sut register:@protocol(DummyProtocol)
           scope:NVRegistryScopePrototype
         factory:^id _Nonnull {
           return [self makeClass:@"ClassName1"];
         }];

  // when
  [_sut remove:@protocol(DummyProtocol)];
  id obj = [_sut resolve:@protocol(DummyProtocol)];

  // then
  XCTAssertNil(obj);
}

#pragma mark - Helpers

- (Protocol *)makeProtocol:(NSString *)name {
  Protocol *aProtocol =
      objc_allocateProtocol([name cStringUsingEncoding:NSMacOSRomanStringEncoding]);
  return aProtocol;
}

- (Class)makeClass:(NSString *)name {
  Class aClass = objc_allocateClassPair(
      [NSObject class], [name cStringUsingEncoding:NSMacOSRomanStringEncoding], 0);
  return aClass;
}

@end

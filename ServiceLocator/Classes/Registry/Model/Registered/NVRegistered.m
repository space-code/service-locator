//
// ServiceLocator
// Copyright © 2024 Space Code. All rights reserved.
//

#import "NVRegistered.h"

@implementation NVRegistered

#pragma mark - Initialization

- (instancetype)initWithSingleton:(id)object {
  self = [super init];
  if (self) {
    _type = NVRegistryScopeSignleton;
    _singletonObject = object;
  }
  return self;
}

- (instancetype)initWithPrototypeBlock:(id _Nonnull (^)(void))block {
  self = [super init];
  if (self) {
    _type = NVRegistryScopePrototype;
    _prototypeBlock = [block copy];
  }
  return self;
}

@end

//
// ServiceLocator
// Copyright © 2024 Space Code. All rights reserved.
//

#import "NVRegistry.h"
#import "NVRegistered.h"

@interface NVRegistry ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, NVRegistered *> *registry;

@end

@implementation NVRegistry

#pragma mark - Initialization

+ (instancetype)sharedInstance {
  static dispatch_once_t token;
  static id sharedInstance = nil;
  dispatch_once(&token, ^{
    sharedInstance = [[[self class] alloc] init];
  });
  return sharedInstance;
}

- (instancetype)init {
  if (self = [super init]) {
    _registry = [[NSMutableDictionary alloc] init];
  }
  return self;
}

#pragma mark - Internal

- (void)register:(Protocol *_Null_unspecified)aProtocol
           scope:(NVScope)scope
         factory:(nonnull id _Nonnull (^)(void))factory {
  switch (scope) {
    case NVRegistryScopeSignleton:
      [self registerSingleton:aProtocol factory:factory];
      break;
    case NVRegistryScopePrototype:
      [self registerPrototype:aProtocol factory:factory];
      break;
  }
}

- (nonnull id)resolve:(Protocol *_Null_unspecified)aProtocol {
  NSString *key = [self makeKey:aProtocol];
  NVRegistered *registered = _registry[key];

  if (registered != nil) {
    switch (registered.type) {
      case NVRegistryScopeSignleton:
        return registered.singletonObject;
      case NVRegistryScopePrototype:
        return registered.prototypeBlock();
    }
  }

  return nil;
}

- (void)remove:(Protocol *)aProtocol {
  NSString *key = [self makeKey:aProtocol];
  [_registry removeObjectForKey:key];
}

#pragma mark - Private

- (nonnull NSString *)makeKey:(Protocol *_Null_unspecified)aProtocol {
  NSString *key = NSStringFromProtocol(aProtocol);
  return key;
}

- (void)registerSingleton:(Protocol *_Null_unspecified)aProtocol
                  factory:(nonnull id _Nonnull (^)(void))factory {
  NSString *key = [self makeKey:aProtocol];
  _registry[key] = [[NVRegistered alloc] initWithSingleton:factory()];
}

- (void)registerPrototype:(Protocol *_Null_unspecified)aProtocol
                  factory:(nonnull id _Nonnull (^)(void))factory {
  NSString *key = [self makeKey:aProtocol];
  _registry[key] = [[NVRegistered alloc] initWithPrototypeBlock:factory];
}

@end

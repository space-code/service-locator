//
// ServiceLocator
// Copyright © 2024 Space Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVScope.h"

NS_ASSUME_NONNULL_BEGIN

/// An object representing a registered dependency.
@interface NVRegistered : NSObject

/// The scope type of the registered dependency.
@property(nonatomic, readonly) NVScope type;

/// The singleton object registered, if applicable.
@property(nonatomic, readonly) id singletonObject;

/// The block to create a prototype object, if applicable.
@property(nonatomic, readonly) id (^prototypeBlock)(void);

/// Initializes the instance with a singleton object.
///
/// @param object The singleton object to initialize with.
///
/// @return An instance of NVRegistered.
- (instancetype)initWithSingleton:(id)object;

/// Initializes the instance with a prototype block.
///
/// @param block The block to create a prototype object.
///
/// @return An instance of NVRegistered.
- (instancetype)initWithPrototypeBlock:(id (^)(void))block;

@end

NS_ASSUME_NONNULL_END

//
// ServiceLocator
// Copyright © 2024 Space Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVScope.h"

NS_ASSUME_NONNULL_BEGIN

/// A class for managing protocol-based dependencies.
@interface NVRegistry : NSObject

/// Returns the shared instance of NVRegistry.
+ (instancetype)sharedInstance;

/// Registers a factory block for the given protocol and scope.
///
/// @param aProtocol The protocol to register.
/// @param scope The scope of the dependency.
/// @param factory A block that returns an instance of the dependency.
- (void)register:(Protocol *_Null_unspecified)aProtocol
           scope:(NVScope)scope
         factory:(id (^)(void))factory;

/// Resolves and returns an instance for the given protocol.
///
/// @param aProtocol The protocol to resolve.
///
/// @return An instance conforming to the given protocol.
- (id)resolve:(Protocol *_Null_unspecified)aProtocol;

/// Removes a dependency with a given protocol.
///
/// @param aProtocol The protocol to delete.
- (void)remove:(Protocol *_Null_unspecified)aProtocol;

@end

NS_ASSUME_NONNULL_END

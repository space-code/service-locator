<h1 align="center" style="margin-top: 0px;">service-locator</h1>

<p align="center">
<a href="https://cocoapods.org/pods/ServiceLocator"><img alt="CodeCov" src="https://img.shields.io/cocoapods/v/ServiceLocator.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/ServiceLocator"><img alt="CodeCov" src="https://img.shields.io/cocoapods/l/ServiceLocator.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/ServiceLocator"><img alt="CodeCov" src="https://img.shields.io/cocoapods/p/ServiceLocator.svg?style=flat"></a>
<a href="https://github.com/space-code/service-locator"><img alt="CI" src="https://github.com/space-code/service-locator/actions/workflows/ci.yml/badge.svg?branch=main"></a>
<a href="https://codecov.io/gh/space-code/service-locator"><img alt="CodeCov" src="https://codecov.io/github/space-code/service-locator/graph/badge.svg?token=ZVqs36MzGZ"></a> 
</p>

## Description
`service-locator` is a framework written in Objective-C that implements a design pattern used in software development to encapsulate the processes involved in obtaining a service with a strong abstraction layer.

- [Usage](#usage)
- [Requirements](#requirements)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Usage

1. Define a protocol:

```objc
@protocol MyProtocol
@end
```

2. Define a class that conforms to this protocol:

```objc
@interface MyClass: NSObject <MyProtocol>
@end
```

3. Register an object in a registry:

```objc
#import <ServiceLocator/ServiceLocator.h>

[[NVRegistry sharedInstance] register:@protocol(MyProtocol) scope:NVRegistryScopePrototype factory:factory:^id _Nonnull {
    return [[MyClass alloc] init];
}];
```

4. Resolve an object based on a protocol:

```objc
#import <ServiceLocator/ServiceLocator.h>

MyClass *myClass = [[NVRegistry sharedInstance] resolve:@protocol(MyProtocol)];
```

## Requirements
- iOS 12.0 / macOS 10.14+ / tvOS 12.0 / watchOS 6.0
- Xcode 15.0

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
service-locator is available under the MIT license. See the LICENSE file for more info.
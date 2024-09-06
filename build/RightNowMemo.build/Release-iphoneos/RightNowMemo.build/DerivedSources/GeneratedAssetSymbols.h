#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "background1" asset catalog image resource.
static NSString * const ACImageNameBackground1 AC_SWIFT_PRIVATE = @"background1";

/// The "background2" asset catalog image resource.
static NSString * const ACImageNameBackground2 AC_SWIFT_PRIVATE = @"background2";

/// The "background3" asset catalog image resource.
static NSString * const ACImageNameBackground3 AC_SWIFT_PRIVATE = @"background3";

/// The "background4" asset catalog image resource.
static NSString * const ACImageNameBackground4 AC_SWIFT_PRIVATE = @"background4";

/// The "custom-arrow-left" asset catalog image resource.
static NSString * const ACImageNameCustomArrowLeft AC_SWIFT_PRIVATE = @"custom-arrow-left";

/// The "custom-arrow-right" asset catalog image resource.
static NSString * const ACImageNameCustomArrowRight AC_SWIFT_PRIVATE = @"custom-arrow-right";

#undef AC_SWIFT_PRIVATE
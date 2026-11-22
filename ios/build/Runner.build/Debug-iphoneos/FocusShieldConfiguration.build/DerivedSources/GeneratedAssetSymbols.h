#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "ShieldMark" asset catalog image resource.
static NSString * const ACImageNameShieldMark AC_SWIFT_PRIVATE = @"ShieldMark";

#undef AC_SWIFT_PRIVATE


#define MKJSingletonH + (instancetype)shareManager;
#define MKJSinletonM \
static id obj; \
 \
+ (instancetype)shareManager \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        obj = [[self alloc] init]; \
    }); \
    return obj; \
} \
 \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        obj = [super allocWithZone:zone]; \
    }); \
    return obj; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return obj; \
}

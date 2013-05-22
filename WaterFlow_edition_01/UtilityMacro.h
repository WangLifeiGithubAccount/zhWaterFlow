//------------------------------------Debug/Release
#ifdef DEBUG
//Debug模式
//...

#else
//Release模式
//屏蔽NSLog
#define NSLog(...) {};

#endif


//------------------------------------Simulator/Device
//区分模拟器和真机
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//------------------------------------ARC/no RAC
//ARC和非ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
//compiling without ARC
#endif



//system version
#define iOS4                                        ([[[UIDevice currentDevice] systemVersion] intValue] == 4)
#define iOS5                                        ([[[UIDevice currentDevice] systemVersion] intValue] == 5)
#define iOS6                                        ([[[UIDevice currentDevice] systemVersion] intValue] == 6)
#define kCurrent_Version                            [[[UIDevice currentDevice] systemVersion] floatValue]


//device
#define isRetina                                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), \
                                                    [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5                                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), \
                                                    [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad                                        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isSimulator                                 (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)


//frame
#define kNavigation_Bar_Height                      44.0
#define kTab_Bar_Height                             49.0

//iPad总是以较短的边作为宽，以较长的边作为高，不像iPhone一样总是以上下边作为宽度，运用时需要注意
//以初始化时竖屏为例，此时width = 768 screenHeight = 1024 contentHeight = 1004，宽是上下两条边，高是左右两条边
//旋转以后宽变为左右两条边，高变为上下两条边，screenWidth = 768 contentWidth = 748 height = 1024

#define kScreen_Width                               [UIScreen mainScreen].bounds.size.width
#define kScreen_Height                              [UIScreen mainScreen].bounds.size.height
#define kScreen_Frame                               CGRectMake(0, 0 ,kScreen_Width, kScreen_Height)
#define kScreen_CenterX                             kScreen_Width / 2
#define kScreen_CenterY                             kScreen_Height / 2

#define kContent_Width                              [UIScreen mainScreen].applicationFrame.size.width
#define kContent_Height                             [UIScreen mainScreen].applicationFrame.size.height
#define kContent_Frame                              CGRectMake(0, 0 ,kContent_Width, kContent_Height)
#define kContent_CenterX                            kContent_Width / 2
#define kContent_CenterY                            kContent_Height / 2


//user default
#define kApp_Delegate                               [[UIApplication sharedApplication] delegate]
#define kNotification_Center                        [NSNotificationCenter defaultCenter]
#define kUser_Default                               [NSUserDefaults standardUserDefaults]
#define kCurrent_Language                           [[NSLocale preferredLanguages] objectAtIndex:0]
#define kCurrent_Calendar                           [NSCalendar currentCalendar]

//degrees/radians
#define kDegreesToRadians(degrees)                  (degrees) * M_PI / 180.0
#define kRadiansToDegrees(radians)                  (radians) * 180.0 / M_PI

//file path
#define kCaches_Path                                [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDocument_Path                              [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//font
#define kSystem_Font(f)                             [UIFont systemFontOfSize:(f)]
#define kBold_System_Font(bf)                       [UIFont boldSystemFontOfSize:(bf)]

//color
#define kRGB(r, g, b)                               [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define kRGBA(r, g, b, a)                           [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define kPatternColor(name)                         [UIColor colorWithPatternImage:kImage(name)]

//image
#define kImage(name)                                [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]
#define kImage_From_Name(name)                      [UIImage imageNamed:name]
#define kStretchable_Image(name, width, height)     [kImage(name) stretchableImageWithLeftCapWidth:width topCapHeight:height]


//log
#define Log(object)                                 NSLog(@"%@", object)
#define LogInt(int)                                 NSLog(@"%d", int)
#define LogBool(bool)                               NSLog(@"%@", bool ? @"YES" : @"NO")
#define LogFloat(float)                             NSLog(@"%f", float)
#define LogPoint(point)                             NSLog(@"x:%f y:%f", point.x, point.y)
#define LogFrame(rect)                              NSLog(@"x:%f y:%f width:%f height:%f", \
                                                    rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
//log with description
#define DLog(description, object)                   NSLog(@"%@ : %@", description, object)
#define DLogInt(description, int)                   NSLog(@"%@ : %d", description, int)
#define DLogBool(description, bool)                 NSLog(@"%@ : %@", description, bool ? @"YES" : @"NO")
#define DLogFloat(description, float)               NSLog(@"%@ : %f", description, float)
#define DLogPoint(description, point)               NSLog(@"%@ : [x:%f y:%f]", description, point.x, point.y)
#define DLogFrame(description, rect)                NSLog(@"%@ : [x:%f y:%f width:%f height:%f]", description, \
                                                    rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)


//statement
#define release(instance)                           {[instance release]; instance = nil;}
#define canOpenURL(url)                             ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]])
#define openURL(url)                                ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]])
#define canTel                                      ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)                            ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber)                      ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:\
                                                    [NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])


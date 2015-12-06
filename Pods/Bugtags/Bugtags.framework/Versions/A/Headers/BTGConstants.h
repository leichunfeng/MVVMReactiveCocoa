//
//  BTGConstants.h
//  Bugtags
//
//  Created by Stephen Zhang on 15/6/4.
//  Copyright (c) 2015年 bugtags.com. All rights reserved.
//

#ifndef Bugtags_BTGConstants_h
#define Bugtags_BTGConstants_h

#ifndef __IPHONE_6_0
#warning "This project uses features only available in iPhone SDK 6.0 and later."
#endif

/**
 *  Bugtags呼出方式
 */
typedef enum BTGInvocationEvent {
    
    // 静默模式，收集Crash信息（如果允许）
    BTGInvocationEventNone,
    
    // 通过摇一摇呼出Bugtags
    BTGInvocationEventShake,
    
    // 通过悬浮小球呼出Bugtags
    BTGInvocationEventBubble,
    
} BTGInvocationEvent;

#endif
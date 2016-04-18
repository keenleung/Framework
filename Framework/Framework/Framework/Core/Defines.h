//
//  Defines.h
//  Framework
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#if __has_feature(objc_generics)
#   define __GENERICS(class, ...)      class<__VA_ARGS__>
#   define __GENERICS_TYPE(type)       type
#else
#   define __GENERICS(class, ...)      class
#   define __GENERICS_TYPE(type)       id
#endif

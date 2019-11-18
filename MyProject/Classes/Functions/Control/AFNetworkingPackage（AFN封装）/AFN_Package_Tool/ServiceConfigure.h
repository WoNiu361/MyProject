//
//  ServiceConfigure.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/12.
//  Copyright © 2019 LYH. All rights reserved.
//

#ifndef ServiceConfigure_h
#define ServiceConfigure_h

#ifdef DEBUG
#define YHLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#define YHLog(...) printf("%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define YHLog(...)
#endif


#endif /* ServiceConfigure_h */

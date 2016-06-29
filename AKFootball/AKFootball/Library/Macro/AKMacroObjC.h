//
//  AKMacroObjC.h
//  AKStudy
//
//  Created by Admin on 18.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#ifndef AKMacroObjC_h
#define AKMacroObjC_h

#define AKWeakify \
            __weak id weakSelf = self;

#define AKWeakifyWithClass(theClass) \
            __weak theClass *weakSelf = self;

#define AKStrongifySelfWithClass(classObject) \
                    __strong classObject *strongSelf = weakSelf; \
                        if (!strongSelf) { \
                    return; \
                    }

#define AKStrongifyAndReturnIfNil \
            __strong __typeof(self) strongSelf = weakSelf;\
                if (!strongSelf) { \
            return; \
            }

#endif /* AKMacroObjC_h */

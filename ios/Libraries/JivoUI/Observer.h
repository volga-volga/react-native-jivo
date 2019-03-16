//
//  Observer.h
//  JivoUI
//
//  Created by Nikita Sirotkin on 17/03/2019.
//  Copyright © 2019 Nikita Sirotkin. All rights reserved.
//

#ifndef Observer_h
#define Observer_h

@protocol Observer <NSObject>

- (void) onEvent: (NSString*) event data: (NSString*) data;

@end

#endif /* Observer_h */

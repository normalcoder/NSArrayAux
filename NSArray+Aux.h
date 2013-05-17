#import <Foundation/Foundation.h>

@interface NSArray (Aux)

- (NSArray *)map:(id (^)(id obj))f;
- (void)map_:(void (^)(id obj))f;
- (id)foldl:(id (^)(id o1, id o2))f :(id)initO;
- (id)foldl1:(id (^)(id o1, id o2))f;
- (NSArray *)concat;
- (NSArray *)unique;

+ (NSArray *):(NSUInteger)from :(NSUInteger)to;

- (NSArray *)minus:(NSArray *)array;
- (NSArray *)intersect:(NSArray *)array;

- (NSArray *)filter:(BOOL (^)(id obj))f;

@end

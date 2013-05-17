#import "NSArray+Aux.h"

@implementation NSArray (Aux)

- (NSArray *)map:(id (^)(id obj))f {
    NSMutableArray * res = [[NSMutableArray alloc] init];
    for (id item in self) {
        [res addObject:f(item)];
    }
    return res;
}

- (void)map_:(void (^)(id obj))f {
    for (id item in self) {
        f(item);
    }
}

- (id)foldl:(id (^)(id o1, id o2))f :(id)initO {
    id tmpRes = initO;
    for (id obj in self) {
        tmpRes = f(tmpRes, obj);
    }
    return tmpRes;
}

- (id)foldl1:(id (^)(id o1, id o2))f {
    assert([self count] > 0);
    
    return [[self subarrayWithRange:(NSRange){1, [self count] - 1}] foldl:f :self[0]];
}

- (NSArray *)concat {
    NSMutableArray * res = [[NSMutableArray alloc] init];
    for (NSArray * item in self) {
        [res addObjectsFromArray:item];
    }
    return res;
}

- (NSArray *)unique {
    NSMutableArray * res = [[NSMutableArray alloc] init];
    for (NSArray * item in self) {
        if (![res containsObject:item]) {
            [res addObject:item];
        }
    }
    return res;
}


+ (NSArray *):(NSUInteger)from :(NSUInteger)to {
    NSMutableArray * res = [NSMutableArray array];
    for (int i=from; i<to; ++i) {
        [res addObject:@(i)];
    }
    return res;
}

- (NSArray *)minus:(NSArray *)array {
    NSSet * unwantedObjs = [NSSet setWithArray:array];
    
    return
    [self filter:^BOOL(id obj) {
        return ![unwantedObjs containsObject:obj];
    }];
}

- (NSArray *)intersect:(NSArray *)array {
    NSSet * wantedObjs = [NSSet setWithArray:array];
    
    return
    [self filter:^BOOL(id obj) {
        return [wantedObjs containsObject:obj];
    }];
}

- (NSArray *)filter:(BOOL (^)(id obj))f {
    return
    [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return f(evaluatedObject);
    }]];
}

@end

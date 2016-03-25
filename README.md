# GqFormtable
Quickly generate forms and provide verification

# use model to init formtable

```objc
//    for(int i = 0; i< 10; i++)
//    {
//        GqFormTableViewSectionGroup *group = [[GqFormTableViewSectionGroup alloc] init];
//        group.headName = [NSString stringWithFormat:@"%@_Head",@(i)];
//        group.footName = [NSString stringWithFormat:@"%@_Foot",@(i)];
//        int k = i + 1;
//        while (k <10) {
//            
//            GqFormTableViewModel *model = [[GqFormTableViewModel alloc] init];
//            model.title = [NSString stringWithFormat:@"%@_title",@(k)];
//            model.deatil = [NSString stringWithFormat:@"%@_deatil",@(k)];
//            model.placeholder = [NSString stringWithFormat:@"%@_placeholder",@(k)];
////            model.maxLength = k;
//            
//            [group.items addObject:model];
//            
//            k++;
//        }
//        [items addObject:group];
//    }
```
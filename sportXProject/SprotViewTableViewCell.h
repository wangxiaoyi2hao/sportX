//
//  SprotViewTableViewCell.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/10.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SprotViewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
{


}
@property(nonatomic,weak)IBOutlet UIView *changeView1;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray*imageAray;
@end

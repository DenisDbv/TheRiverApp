//
//  TRAlbumGridViewCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 06.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "AQGridViewCell.h"

@interface TRAlbumGridViewCell : AQGridViewCell
{
    UIImageView * _imageView;
}

@property (nonatomic, retain) UIImage * image;

@end